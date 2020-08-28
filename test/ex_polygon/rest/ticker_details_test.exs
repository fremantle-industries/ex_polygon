defmodule ExPolygon.Rest.TickerDetailsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".query returns an ok tuple with ticker details" do
    use_cassette "rest/ticker_details/query_ok" do
      assert {:ok, details} = ExPolygon.Rest.TickerDetails.query("AAPL", @api_key)
      assert %ExPolygon.TickerDetail{} = details
    end
  end
end
