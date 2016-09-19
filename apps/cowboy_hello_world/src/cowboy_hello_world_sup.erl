%%%-------------------------------------------------------------------
%% @doc cowboy_hello_world top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(cowboy_hello_world_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

%% API.

-spec start_link() -> {ok, pid()}.
start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).


%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}

init([]) ->
	Procs = [],
	{ok, {{one_for_one, 10, 10}, Procs}}.


%%====================================================================
%% Internal functions
%%====================================================================

