-module(rebar3_garlang_compiler).

-export([init/1]).

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    {ok, State1} = rebar3_prv_garlang_compiler:init(State),
    {ok, State1}.
