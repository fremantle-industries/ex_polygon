defmodule ExPolygon.Rest.Locales do
  @path "/v2/reference/locales"
  def all(api_key) do
    @path
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response()
  end

  def parse_response({:ok, %{"status" => "OK", "results" => results}}) do
    locales =
      results
      |> Enum.map(&Mapail.map_to_struct(&1, ExPolygon.Locale, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, locales}
  end
end
