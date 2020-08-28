defmodule ExPolygon.Rest.TypesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".query returns an ok tuple with a list of types" do
    use_cassette "rest/types/query_ok" do
      assert {:ok, type} = ExPolygon.Rest.TickerTypes.query(@api_key)
      assert %ExPolygon.TickerType{} = type
      assert type.types != nil
      assert type.index_types != nil
    end
  end
end
