# Network collision mapper

Provides facilities to track, optimize networks of nodes and check for collisions between them.

## Requisites

- Elixir
- Erlang
- Phoenix Framework

## Installation instructions

Install Elixir, Erlang and Phoenix following the instructions from this [page](http://www.phoenixframework.org/docs/installation).

## Build

To be able to run tests and the embedded web server, first download the application dependencies

```bash
mix deps.get
```

## Running tests

Simply run the following command from a terminal

```bash
mix test
```

## Starting the REST API

The API starts at localhost:4000, by default; make sure that host and port combination is available

```bash
mix phoenix.server
```