cowboy_hello_world
=====

An Erlang/Cowboy web application demo created from scratch using rebar3 build tool

(inspired from [this tutorial "Erlang, Rebar3, and Cowboy"](https://www.themoorecollective.com/articles/2015/12/09/Erlang,%20Rebar3,%20and%20Cowboy) with small updates)


Software used
-----

Erlang ([Erlang/OTP 19](https://www.erlang-solutions.com/resources/download.html))

Cowboy ([Master branch](https://github.com/ninenines/cowboy))

Rebar3 ([http://www.rebar3.org](http://www.rebar3.org))


Create and build
-----

	1. Create empty Erlang release and application with Rebar3

		$ rebar3 new release cowboy_hello_world 

		$ cd cowboy_hello_world


	2. Make changes to automatically generated rebar.config 

		$ vi rebar.config 

		2.1. Add Cowboy dependency to deps section of rebar.config 
			{deps, [
			        {cowboy, {git, "https://github.com/ninenines/cowboy", {branch, "master"}}}
			]}.

		2.2. Add rebar3_run dependency to plugins section of rebar.config 
			{plugins, [rebar3_run]}.


	3. Add reference to Cowboy in application description file

		$ vi apps/cowboy_hello_world/src/cowboy_hello_world.app.src

			{applications,
			   [kernel,
			    stdlib,
			    cowboy
			]},


	4. Register a handler for the / url

		$ vi apps/cowboy_hello_world/src/cowboy_hello_world_app.erl  

		start(_Type, _Args) ->
		        Dispatch = cowboy_router:compile([
		                {'_', [
		                        {"/", toppage_handler, []}
		                ]}
		        ]),
		        {ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
		                env => #{dispatch => Dispatch}
		        }),
		        cowboy_hello_world_sup:start_link().


	5. And create handle referenced above

		$ vi apps/cowboy_hello_world/src/toppage_handler.erl

		-module(toppage_handler).

		-export([init/2]).

		init(Req0, Opts) ->
		        Req = cowboy_req:reply(200, #{
		                <<"content-type">> => <<"text/plain">>
		        }, <<"Hello world!">>, Req0),
		        {ok, Req, Opts}.


	6. Compile

		$ rebar3 compile


	7. Run

		$ rebar3 shell

		Open http://localhost:8080 in browser


	8. Clean 

		$ rebar3 clean; rm -rf _build rebar.lock


	9. Create release

		$ rebar3 release


	10. Start release

		$ _build/default/rel/cowboy_hello_world/bin/cowboy_hello_world console
		
		Open http://localhost:8080 in browser

