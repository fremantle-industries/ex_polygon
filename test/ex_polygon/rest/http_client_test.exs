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

  test ".get returns an error tuple when unauthorized" do
    use_cassette "rest/http_client/get_unauthorized_error" do
      assert {:error, reason} =
               ExPolygon.Rest.HTTPClient.get(
                 "/v1/marketstatus/now",
                 %{},
                 @api_key
               )

      assert reason ==
               {:unauthorized, "API Key - Alpaca API Keys are not permissioned for this route"}
    end
  end
end
