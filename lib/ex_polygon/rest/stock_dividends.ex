defmodule ExPolygon.Rest.StockDividends do
  @type dividend :: ExPolygon.Dividend.t()
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type shared_error_reasons :: ExPolygon.Rest.HTTPClient.shared_error_reasons()

  @path "/v2/reference/dividends/:symbol"

  @spec query(String.t(), api_key) :: {:ok, [dividend]} | {:error, shared_error_reasons}
  def query(symbol, api_key) do
    with {:ok, data} <-
           @path
           |> String.replace(":symbol", symbol)
           |> ExPolygon.Rest.HTTPClient.get(%{}, api_key) do
      parse_response(data)
    end
  end

  defp parse_response(%{"status" => "OK", "results" => results}) do
    dividends =
      results
      |> Enum.map(&Mapail.map_to_struct(&1, ExPolygon.Dividend, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, dividends}
  end
end
