%%%-------------------------------------------------------------------
%%% File    : supervisor.erl
%%% Author  : Samuel Rivas <samuel@lambdastream.com>
%%% Description : Erlcunia's main supervisor
%%%
%%% Created : 23 Sep 2006 by Samuel Rivas <samuel@lambdastream.com>
%%%-------------------------------------------------------------------
-module(erlcunia_supervisor).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================
%%--------------------------------------------------------------------
%% Function: start_link() -> {ok,Pid} | ignore | {error,Error}
%% Description: Starts the supervisor
%%--------------------------------------------------------------------
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================
%%--------------------------------------------------------------------
%% Func: init(Args) -> {ok,  {SupFlags,  [ChildSpec]}} |
%%                     ignore                          |
%%                     {error, Reason}
%% Description: Whenever a supervisor is started using 
%% supervisor:start_link/[2,3], this function is called by the new process 
%% to find out about restart strategy, maximum restart frequency and child 
%% specifications.
%%--------------------------------------------------------------------
init([]) ->
    {ok,{{one_for_one,10,1}, children()}}.

%%====================================================================
%% Internal functions
%%====================================================================
children() ->
    [childspec(X) || X <- ['erlcunia.lesson.player',
			   'erlcunia.lesson.tutor',
			   'erlcunia.midi.player']].

childspec(Name) ->
    {Name, {Name, start_link, []}, permanent, 2000, worker, [Name]}.
