defmodule ExPolygon.Rest.LocalesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".query returns an ok tuple with a list of locales" do
    use_cassette "rest/locales/query_ok" do
      assert {:ok, locales} = ExPolygon.Rest.Locales.query(@api_key)
      assert [%ExPolygon.Locale{} = _ | _] = locales
    end
  end
end
