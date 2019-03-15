defmodule ExPolygon.Rest.Types do
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type type :: ExPolygon.Type.t()

  @path "/v2/reference/types"

  @spec all(api_key) :: {:ok, type}
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
