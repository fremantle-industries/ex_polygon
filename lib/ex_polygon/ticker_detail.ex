defmodule ExPolygon.TickerDetail do
  @type t :: %ExPolygon.TickerDetail{}

  defstruct ~w(
    logo
    exchange
    name
    symbol
    listdate
    cik
    bloomberg
    figi
    lei
    sic
    country
    industry
    sector
    marketcap
    employees
    phone
    ceo
    url
    description
    similar
    tags
    updated
  )a
end
