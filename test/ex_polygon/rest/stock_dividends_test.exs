defmodule ExPolygon.Rest.StockDividendsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".query returns an ok tuple with a list of dividends" do
    use_cassette "rest/stock_dividends/query_ok" do
      assert {:ok, dividends} = ExPolygon.Rest.StockDividends.query("AAPL", @api_key)
      assert [%ExPolygon.Dividend{} = _ | _] = dividends
    end
  end
end
