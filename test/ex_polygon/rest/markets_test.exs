defmodule ExPolygon.Rest.MarketsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".all returns an ok tuple with a list of markets" do
    use_cassette "rest/markets/all_ok" do
      assert {:ok, markets} = ExPolygon.Rest.Markets.all(@api_key)
      assert [%ExPolygon.Market{} = _ | _] = markets
    end
  end
end
