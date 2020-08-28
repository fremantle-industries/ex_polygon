defmodule ExPolygon.Rest.MarketStatus do
  @type status :: ExPolygon.MarketStatus.t()
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type shared_error_reasons :: ExPolygon.Rest.HTTPClient.shared_error_reasons()

  @path "/v1/marketstatus/now"

  @spec query(api_key) :: {:ok, map} | {:error, shared_error_reasons}
  def query(api_key) do
    with {:ok, data} <- ExPolygon.Rest.HTTPClient.get(@path, %{}, api_key) do
      parse_response(data)
    end
  end

  defp parse_response(data) do
    {:ok, status} =
      Mapail.map_to_struct(data, ExPolygon.MarketStatus, transformations: [:snake_case])

    {:ok, status}
  end
end
