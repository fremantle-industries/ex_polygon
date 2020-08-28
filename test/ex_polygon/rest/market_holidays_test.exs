defmodule ExPolygon.Rest.MarketHolidaysTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".query returns an ok tuple with a list of holidays" do
    use_cassette "rest/market_holidays/query_ok" do
      assert {:ok, holidays} = ExPolygon.Rest.MarketHolidays.query(@api_key)
      assert [%ExPolygon.MarketHoliday{} = _ | _] = holidays
    end
  end
end
