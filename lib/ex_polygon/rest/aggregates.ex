defmodule ExPolygon.Rest.Aggregates do
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type aggregate :: ExPolygon.Aggregate.t()

  @path "/v2/aggs/ticker/:symbol/range/:multiplier/:timespan/:from/:to"

  @spec query(
          String.t(),
          non_neg_integer | String.t(),
          String.t(),
          String.t(),
          String.t(),
          api_key
        ) ::
          {:ok, aggregate}
  def query(symbol, multiplier, timespan, from, to, api_key) when is_integer(multiplier) do
    query(symbol, multiplier |> Integer.to_string(), timespan, from, to, api_key)
  end

  def query(symbol, multiplier, timespan, from, to, api_key) do
    @path
    |> String.replace(":symbol", symbol)
    |> String.replace(":multiplier", multiplier)
    |> String.replace(":timespan", timespan)
    |> String.replace(":from", from)
    |> String.replace(":to", to)
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response()
  end

  def parse_response({:ok, %{"results" => results} = data}) do
    results =
      results
      |> Enum.map(
        &Mapail.map_to_struct(&1, ExPolygon.AggregateResult, transformations: [:snake_case])
      )
      |> Enum.map(fn {:ok, result} -> result end)

    {:ok, aggregate} =
      data
      |> Map.put("results", results)
      |> Mapail.map_to_struct(ExPolygon.Aggregate, transformations: [:snake_case])

    {:ok, aggregate}
  end
end
