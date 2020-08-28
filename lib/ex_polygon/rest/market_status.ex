defmodule ExPolygon.Rest.MarketStatus do
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type shared_error_reasons :: ExPolygon.Rest.HTTPClient.shared_error_reasons()

  @path "/v1/marketstatus/now"

  @spec query(api_key) :: {:ok, map} | {:error, shared_error_reasons}
  def query(api_key) do
    with {:ok, data} <- ExPolygon.Rest.HTTPClient.get(@path, %{}, api_key) do
      # TODO Not sure if it needs its own struct
      {:ok, data}
    end
  end
end
