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

## Generating random network node pairs file

```bash
mix networks_file.generate --help
```

## Feeding network node pairs file into the Rest API

```bash
mix networks_file.feed --help
```

## Rest API documentation

- [List networks](rest-api-list-networks.md)
- [Create networks](rest-api-create-networks.md)
- [Check for collisions](rest-api-check-collisions.md)
- [Check for intersections](rest-api-check-intersections.md)