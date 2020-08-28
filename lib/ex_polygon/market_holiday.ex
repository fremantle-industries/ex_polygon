defmodule ExPolygon.MarketHoliday do
  @type t :: %ExPolygon.MarketHoliday{}

  defstruct ~w(exchange name status date open close)a
end
