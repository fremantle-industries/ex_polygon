defmodule ExPolygon.Rest.AggregatesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".query returns an ok tuple and the aggregate" do
    use_cassette "rest/aggregates/query_ok" do
      assert {:ok, aggregate} =
               ExPolygon.Rest.Aggregates.query(
                 "AAPL",
                 1,
                 "minute",
                 "2019-01-01",
                 "2019-03-01",
                 @api_key
               )

      assert %ExPolygon.Aggregate{} = aggregate
      assert aggregate.adjusted != nil
      assert [%ExPolygon.AggregateResult{} = result | _] = aggregate.results
      assert result.v != nil
    end
  end
end
