defmodule ExPolygon.Rest.Tickers do
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type tickers :: ExPolygon.Tickers.t()

  @path "/v2/reference/tickers"

  @spec query(map, api_key) :: {:ok, tickers}
  def query(params, api_key) do
    @path
    |> ExPolygon.Rest.HTTPClient.get(params, api_key)
    |> parse_response()
  end

  defp parse_response({:ok, %{"tickers" => raw_tickers} = data}) do
    tickers =
      raw_tickers
      |> Enum.map(&Mapail.map_to_struct(&1, ExPolygon.Ticker, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    data
    |> Map.put("tickers", tickers)
    |> Mapail.map_to_struct(ExPolygon.Tickers, transformations: [:snake_case])
  end
end
