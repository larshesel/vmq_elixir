# vmq_elixir

This plugin makes VerneMQ able to work with plugins written in Elixir. All it
does is to load the path to the Elixir beam files and starts the `elixir`
application.

## Prerequisites

* A VerneMQ installation (in particular, `vmq-admin` should be in your path).
* Erlang and Elixir installed.
* rebar3 available.

## install

In order to install fetch `vmq_elixir`:

```shell
  $ git clone github.com/erl.io/vmq_elixir
  $ cd vmq_elixir
```

Then edit the ``elixir_lib_path()` function in `src/vmq_elixir_app.erl` so it
points to your elixir `lib` directory.

```shell
    $ ./rebar3 compile
```

To install this plugin into vernemq do:

```shell
  $ vmq-admin plugin enable --name=vmq_elixir --path=`pwd`/_build/default/lib/vmq_elixir
```

Check the `vmq_elixir` plugin is loaded. `vmq-admin plugin show`
should return something like:

```shell
$ vmq-admin plugin show
+-----------+-----------+-----------------+-----------------------------+
|  Plugin   |   Type    |     Hook(s)     |            M:F/A            |
+-----------+-----------+-----------------+-----------------------------+
|vmq_systree|application|                 |                             |
|vmq_passwd |application|auth_on_register |vmq_passwd:auth_on_register/5|
|  vmq_acl  |application| auth_on_publish |  vmq_acl:auth_on_publish/6  |
|           |           |auth_on_subscribe| vmq_acl:auth_on_subscribe/3 |
|vmq_elixir |application|                 |                             |
+-----------+-----------+-----------------+-----------------------------+
```

