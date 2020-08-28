defmodule ExPolygon.StockSplit do
  @type t :: %ExPolygon.StockSplit{}

  defstruct ~w(ticker ex_date payment_date record_date declare_date ratio to_factor for_factor)a
end
