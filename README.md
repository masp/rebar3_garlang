rebar3_garlang_compiler
=====

Extends rebar3 to compile .gar files.

Installation
----
Make sure you have `gar` installed


Add the plugin to your `rebar.config`:

```
{plugins, [
    {rebar3_garlang_compiler, ".*", {git, "https://github.com/masp/rebar3_garlang.git", {branch, "main"}}}
]}.
```

Then just call your plugin directly in an existing application:

```
$ rebar3 gar compile
===> Fetching rebar3_garlang_compiler
===> Compiling rebar3_garlang_compiler
<Plugin Output>
```

Add it as a compile hook so you don't have to type it every time:

```
{provider_hooks, [
    {pre, [
        {compile, {gar, compile}}
    ]}
]}.
```
