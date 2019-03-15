defmodule ExPolygon.Rest.Companies do
  @path "/v1/meta/symbols"
  @details "company"
  @ratings "analysts"

  def details(symbol, api_key) do
    [@path, symbol, @details]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response(ExPolygon.Company)
  end

  def ratings(symbol, api_key) do
    [@path, symbol, @ratings]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response(ExPolygon.CompanyRatings)
  end

  def parse_response({:ok, data}, mod) do
    {:ok, data} = Mapail.map_to_struct(data, mod, transformations: [:snake_case])
    {:ok, data}
  end
end
