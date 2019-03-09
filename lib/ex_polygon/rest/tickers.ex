defmodule ExPolygon.Rest.Tickers do
  @path "/v2/reference/tickers"
  def all(params, api_key) do
    @path
    |> ExPolygon.Rest.HTTPClient.get(params, api_key)
    |> parse_response()
  end

  def parse_response({:ok, %{"tickers" => raw_tickers} = data}) do
    tickers =
      raw_tickers
      |> Enum.map(&Mapail.map_to_struct(&1, ExPolygon.Ticker, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    data
    |> Map.put("tickers", tickers)
    |> Mapail.map_to_struct(ExPolygon.Tickers, transformations: [:snake_case])
  end
end
