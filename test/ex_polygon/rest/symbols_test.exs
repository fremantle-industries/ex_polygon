defmodule ExPolygon.Rest.SymbolsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".company_details returns an ok tuple with the company detail" do
    use_cassette "rest/symbols/company_details_ok" do
      assert {:ok, detail} = ExPolygon.Rest.Symbols.company_details("AAPL", @api_key)
      assert %ExPolygon.CompanyDetail{} = detail
      assert detail.exchange_symbol != nil
    end
  end

  test ".ratings returns an ok tuple with the ratings" do
    use_cassette "rest/symbols/ratings_ok" do
      assert {:ok, ratings} = ExPolygon.Rest.Symbols.ratings("AAPL", @api_key)
      assert %ExPolygon.CompanyRatings{} = ratings
      assert ratings.analysts != nil
    end
  end

  test ".dividends returns an ok tuple with a list of dividends" do
    use_cassette "rest/symbols/dividends_ok" do
      assert {:ok, dividends} = ExPolygon.Rest.Symbols.dividends("AAPL", @api_key)
      assert [%ExPolygon.Dividend{} = dividend | _] = dividends
      assert dividend.payment_date != nil
    end
  end

  test ".earnings returns an ok tuple with a list of earnings" do
    use_cassette "rest/symbols/earnings_ok" do
      assert {:ok, earnings} = ExPolygon.Rest.Symbols.earnings("AAPL", @api_key)
      assert [%ExPolygon.Earning{} = earning | _] = earnings
      assert earning.actual_eps != nil
    end
  end

  test ".financials returns an ok tuple with a list of financials" do
    use_cassette "rest/symbols/financials_ok" do
      assert {:ok, financials} = ExPolygon.Rest.Symbols.financials("AAPL", @api_key)
      assert [%ExPolygon.Financial{} = financial | _] = financials
      assert financial.gross_profit != nil
    end
  end
end
