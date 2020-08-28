defmodule ExPolygon.Rest.TickerDetails do
  @type details :: ExPolygon.TickerDetail.t()
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type shared_error_reasons :: ExPolygon.Rest.HTTPClient.shared_error_reasons()

  @path "/v1/meta/symbols/:symbol/company"

  @spec query(String.t(), api_key) :: {:ok, [details]} | {:error, shared_error_reasons}
  def query(symbol, api_key) do
    with {:ok, data} <-
           @path
           |> String.replace(":symbol", symbol)
           |> ExPolygon.Rest.HTTPClient.get(%{}, api_key) do
      parse_response(data)
    end
  end

  defp parse_response(data) do
    {:ok, type} =
      Mapail.map_to_struct(data, ExPolygon.TickerDetail, transformations: [:snake_case])

    {:ok, type}
  end
end
