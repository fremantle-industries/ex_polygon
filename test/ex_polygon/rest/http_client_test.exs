defmodule ExPolygon.Rest.HTTPClientTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".get returns an ok tuple with the parsed json data" do
    use_cassette "rest/http_client/request_ok" do
      assert {:ok, tickers} =
               ExPolygon.Rest.HTTPClient.get(
                 "/v2/reference/tickers",
                 %{locale: "us"},
                 @api_key
               )

      assert tickers |> Map.get("count") != nil
    end
  end
end
