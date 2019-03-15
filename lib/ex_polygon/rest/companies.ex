defmodule ExPolygon.Rest.Companies do
  @path "/v1/meta/symbols"
  @details "company"

  def details(symbol, api_key) do
    [@path, symbol, @details]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response()
  end

  def parse_response({:ok, data}) do
    {:ok, company} = Mapail.map_to_struct(data, ExPolygon.Company, transformations: [:snake_case])
    {:ok, company}
  end
end
