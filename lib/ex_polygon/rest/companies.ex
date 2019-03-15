defmodule ExPolygon.Rest.Companies do
  @path "/v1/meta/symbols"
  @details "company"
  @ratings "analysts"
  @dividends "dividends"
  @earnings "earnings"
  @financials "financials"

  def details(symbol, api_key) do
    [@path, symbol, @details]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response(ExPolygon.Company)
  end

  def ratings(symbol, api_key) do
    [@path, symbol, @ratings]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response(ExPolygon.CompanyRatings)
  end

  def dividends(symbol, api_key) do
    [@path, symbol, @dividends]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response([ExPolygon.Dividend])
  end

  def earnings(symbol, api_key) do
    [@path, symbol, @earnings]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response([ExPolygon.Earning])
  end

  def financials(symbol, api_key) do
    [@path, symbol, @financials]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response([ExPolygon.Financial])
  end

  defp parse_response({:ok, data}, [mod | _]) do
    list =
      data
      |> Enum.map(&Mapail.map_to_struct(&1, mod, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, list}
  end

  defp parse_response({:ok, data}, mod) do
    {:ok, data} = Mapail.map_to_struct(data, mod, transformations: [:snake_case])
    {:ok, data}
  end
end
