defmodule ExPolygon.MarketStatus do
  @type t :: %ExPolygon.MarketStatus{}

  defstruct ~w(currencies exchanges market server_time)a
end
