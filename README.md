# BTS

Implementation of Binary search tree with insert.
This have been doen using a tuple of form {Value, Left, Right}.

# restAPI

In order to dock the listener simply call "RESTAPI.accept(9000)" (it could be any port 9000 is just a placeholder)
I used telenet to communicate with the server by calling "telnet 127.0.0.1 9000" and then giving either 1 number or mutiple seperated by commas. example "1,2 ,3,5 ,6"  or "50, 25, 100, 30, 75, 200"

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bts` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bts, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/bts](https://hexdocs.pm/bts).

