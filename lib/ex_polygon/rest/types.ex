defmodule ExPolygon.Rest.Types do
  @path "/v2/reference/types"
  def all(api_key) do
    @path
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response()
  end

  def parse_response({:ok, %{"status" => "OK", "results" => results}}) do
    {:ok, type} = Mapail.map_to_struct(results, ExPolygon.Type, transformations: [:snake_case])
    {:ok, type}
  end
end
