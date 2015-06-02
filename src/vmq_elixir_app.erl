-module(vmq_elixir_app).

-behaviour(application).
-export([start/2, stop/1]).

-behaviour(supervisor).
-export([init/1]).


%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    case application:ensure_started(elixir) of
        ok ->
            %% Elixir is already started and hence we do not need to
            %% guess where the elixir beam files are located.
            ok;
        _ ->
            ok = add_elixir_dirs_to_path(code:lib_dir(vmq_elixir)),
            {ok, _} = application:ensure_all_started(elixir)
    end,
    supervisor:start_link({local,?MODULE},?MODULE,[]).

add_elixir_dirs_to_path(BasePath) ->
    Dirs =
        %% If built with Rebar2:
        filelib:wildcard(BasePath ++ "/deps/elixir/lib/*/ebin") ++
        %% If built with rebar3:
        filelib:wildcard(BasePath ++ "/../elixir/lib/*/ebin"),
    case Dirs of
        [] ->
            {error, elixir_not_found};
        _ ->
            [code:add_patha(Dir) || Dir <- Dirs],
            ok
    end.

init([]) ->
    {ok, {{one_for_one,3,10},[]}}.

stop(_State) ->
    ok.
