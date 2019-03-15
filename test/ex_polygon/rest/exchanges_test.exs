defmodule ExPolygon.Rest.ExchangesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".all returns an ok tuple with a list of exchanges" do
    use_cassette "rest/exchanges/all_ok" do
      assert {:ok, exchanges} = ExPolygon.Rest.Exchanges.all(@api_key)
      assert [%ExPolygon.Exchange{} = exchange | _] = exchanges
      assert exchange.type != nil
    end
  end
end
