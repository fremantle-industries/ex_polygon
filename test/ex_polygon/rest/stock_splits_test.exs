defmodule ExPolygon.Rest.StockSplitsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".query returns an ok tuple with a list of splits" do
    use_cassette "rest/stock_splits/query_ok" do
      assert {:ok, splits} = ExPolygon.Rest.StockSplits.query("AAPL", @api_key)
      assert [%ExPolygon.StockSplit{} = _ | _] = splits
    end
  end
end
