rebar3_garlang_compiler
=====

Extends rebar3 to compile .gar files using the gar compiler.

Installation
----

Add the plugin to your rebar config:

```
{plugins, [
    { rebar3_garlang_compiler, ".*", {git, "https://github.com/tsloughter/rebar3_ex_compiler.git", {branch, "master"}}}
]}.
```

Then just call your plugin directly in an existing application:

```
$ rebar3 gar compile
===> Fetching rebar3_ex_compiler
===> Compiling rebar3_ex_compiler
<Plugin Output>
```

Or add it as a compile hook:

```
{provider_hooks, [{pre, [{compile, {gar, compile}}]}]}.
```
