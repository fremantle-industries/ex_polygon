# ExPolygon
[![CircleCI](https://circleci.com/gh/fremantle-capital/ex_polygon.svg?style=svg)](https://circleci.com/gh/fremantle-capital/ex_polygon)

Polygon.io API Client for Elixir

## Installation

List the Hex package in your application dependencies.

```elixir
def deps do
  [
    {:ex_polygon, "~> 0.0.4"}
  ]
end
```

Run mix deps.get to install.

## Configuration

Add the following configuration variables in your `config/config.exs` file:

```elixir
use Mix.Config

config :ex_polygon, endpoint: "https://api.polygon.io"
```

## Usage

Pass the api key along to any API calls you make

```elixir
{:ok, locales} = ExPolygon.Rest.Locales.query("MY_API_KEY")
```
