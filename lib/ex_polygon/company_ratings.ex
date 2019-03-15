defmodule ExPolygon.CompanyRatings do
  defstruct ~w(
    symbol
    analysts
    change
    strong_buy
    buy
    hold
    sell
    strong_sell
    updated
  )a
end
