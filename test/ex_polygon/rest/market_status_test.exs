defmodule ExPolygon.Rest.MarketStatusTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".query returns an ok tuple with a market status" do
    use_cassette "rest/market_status/query_ok" do
      assert {:ok, status} = ExPolygon.Rest.MarketStatus.query(@api_key)
      assert %ExPolygon.MarketStatus{} = status
    end
  end
end
