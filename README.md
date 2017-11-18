# No

This is `no` command implemented in Elixir.
By default, `n` will be output forever.

```
> ./no
n
n
n
n
...
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `no` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:no, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/no](https://hexdocs.pm/no).

## Options

`-p <number>` option spawns `no` process that outputs `n` by the specified number.

```
> ./no -p 100
```

`-d` option outputs debug info in the spawned process.

```
> ./no -p 100 -d
{"n from process no.1", #PID<0.76.0>}
{"n from process no.36", #PID<0.111.0>}
{"n from process no.54", #PID<0.129.0>}
{"n from process no.1", #PID<0.76.0>}
{"n from process no.54", #PID<0.129.0>}
{"n from process no.36", #PID<0.111.0>}
{"n from process no.1", #PID<0.76.0>}
{"n from process no.36", #PID<0.111.0>}
...
```

