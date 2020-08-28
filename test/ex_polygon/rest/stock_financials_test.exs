defmodule ExPolygon.Rest.StockFinancialsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".query returns an ok tuple and a list of financial for the ticker" do
    use_cassette "rest/stock_financials/query_ok" do
      assert {:ok, financials} =
               ExPolygon.Rest.StockFinancials.query(
                 "AAPL",
                 %{"limit" => 5, "type" => "Y"},
                 @api_key
               )

      assert [%ExPolygon.Financial{} = _ | _] = financials
    end
  end
end
