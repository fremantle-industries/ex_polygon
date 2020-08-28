defmodule ExPolygon.Rest.TickerNewsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".query returns an ok tuple and news for the ticker" do
    use_cassette "rest/ticker_news/query_ok" do
      assert {:ok, news} =
               ExPolygon.Rest.TickerNews.query(
                 "AAPL",
                 %{"perpage" => 50, "page" => 1},
                 @api_key
               )

      assert [%ExPolygon.News{} = _ | _] = news
    end
  end
end
