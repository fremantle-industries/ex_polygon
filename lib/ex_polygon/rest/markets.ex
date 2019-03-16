defmodule ExPolygon.Rest.Markets do
  @type market :: ExPolygon.Market.t()
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()

  @path "/v2/reference/markets"

  @spec query(api_key) :: {:ok, [market]}
  def query(api_key) do
    @path
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response()
  end

  def parse_response({:ok, %{"status" => "OK", "results" => results}}) do
    markets =
      results
      |> Enum.map(&Mapail.map_to_struct(&1, ExPolygon.Market, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, markets}
  end
end
