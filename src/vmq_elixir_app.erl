-module(vmq_elixir_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    case application:get_env(vmq_elixir, elixir_path) of
        undefined ->
            set_path(built_in_elixir_path());
        path ->
            %% TODO
            ok
    end,
    ok.

set_path(path) ->
    code:add_patha(path).

stop(_State) ->
    ok.
