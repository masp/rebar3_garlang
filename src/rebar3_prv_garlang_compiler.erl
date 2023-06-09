-module(rebar3_prv_garlang_compiler).

-export([init/1, do/1, format_error/1]).

-define(PROVIDER, compile).
-define(NAMESPACE, gar).
-define(DEPS, [{default, app_discovery}]).

%% ===================================================================
%% Public API
%% ===================================================================
-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    Provider = providers:create([
        {name, ?PROVIDER},
        {namespace, ?NAMESPACE},
        {module, ?MODULE},
        {bare, true},
        {deps, ?DEPS},
        {example, "rebar3 gar compile"},
        {opts, []},
        {short_desc, "Compiles any gar files in the project."},
        {desc, ""}
    ]),
    {ok, rebar_state:add_provider(State, Provider)}.

-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
    rebar_api:debug("Compiling gar files", []),
    Apps =
        case rebar_state:current_app(State) of
            undefined ->
                rebar_state:project_apps(State);
            AppInfo ->
                [AppInfo]
        end,
    [
        begin
            Opts = rebar_app_info:opts(AppInfo),
            OutDir = rebar_app_info:out_dir(AppInfo),
            SourceDir = filename:join(rebar_app_info:dir(AppInfo), "src"),
            FoundFiles = rebar_utils:find_files(SourceDir, ".*\\.gar\$"),

            CompileFun = fun(Source, Opts1) ->
                gar_compile(Opts1, Source, OutDir)
            end,
            rebar_api:debug("Compiling gar files: ~p", [FoundFiles]),
            rebar_base_compiler:run(Opts, [], FoundFiles, CompileFun)
        end
     || AppInfo <- Apps
    ],

    {ok, State}.

-spec format_error(any()) -> iolist().
format_error(Reason) ->
    io_lib:format("~p", [Reason]).

gar_compile(_Opts, Source, OutDir) ->
    BeamDir = filename:join(OutDir, "ebin"),
    ok = filelib:ensure_dir(BeamDir),
    rebar_utils:sh(io_lib:format("gar build -o ~s -beam ~s", [BeamDir, Source]), []).
