defmodule ExPolygon.Rest.TickerNews do
  @type news :: ExPolygon.News.t()
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type shared_error_reasons :: ExPolygon.Rest.HTTPClient.shared_error_reasons()

  @path "/v1/meta/symbols/:symbol/news"

  # params is a string format map, that contains possible parameters
  # for the call, like %{"perpage" => 3, "page" => 1} etc
  @spec query(String.t(), map, api_key) :: {:ok, [news]} | {:error, shared_error_reasons}
  def query(symbol, params \\ %{}, api_key) do
    with {:ok, data} <-
           @path
           |> String.replace(":symbol", symbol)
           |> ExPolygon.Rest.HTTPClient.get(params, api_key) do
      parse_response(data)
    end
  end

  defp parse_response(data) do
    news =
      data
      |> Enum.map(&Mapail.map_to_struct(&1, ExPolygon.News, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, news}
  end
end
