-module(vmq_elixir_app).

-behaviour(application).
-export([start/2, stop/1]).

-behaviour(supervisor).
-export([init/1]).


%% ===================================================================
%% Application callbacks
%% ===================================================================

elixir_lib_path() ->
    %% example path: "/usr/local/elixir/lib"
    "/home/opt/elixir/elixir/lib".

start(_StartType, _StartArgs) ->
    case application:ensure_started(elixir) of
        ok ->
            %% Elixir is already started.
            ok;
        _ ->
            ok = add_elixir_dirs_to_path(elixir_lib_path()),
            {ok, _} = application:ensure_all_started(elixir)
    end,
    supervisor:start_link({local,?MODULE},?MODULE,[]).

add_elixir_dirs_to_path(BasePath) ->
    Dirs =
        filelib:wildcard(BasePath ++ "/*/ebin"),
    case Dirs of
        [] ->
            {error, incorrect_elixir_path};
        _ ->
            [code:add_patha(Dir) || Dir <- Dirs],
            ok
    end.

init([]) ->
    {ok, {{one_for_one,3,10},[]}}.

stop(_State) ->
    ok.
