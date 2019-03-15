defmodule ExPolygon.Rest.CompaniesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPolygon.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @api_key System.get_env("POLYGON_API_KEY")

  test ".details returns an ok tuple with the company details" do
    use_cassette "rest/companies/details_ok" do
      assert {:ok, company} = ExPolygon.Rest.Companies.details("AAPL", @api_key)
      assert %ExPolygon.Company{} = company
      assert company.exchange_symbol != nil
    end
  end

  test ".ratings returns an ok tuple with the ratings" do
    use_cassette "rest/companies/ratings_ok" do
      assert {:ok, ratings} = ExPolygon.Rest.Companies.ratings("AAPL", @api_key)
      assert %ExPolygon.CompanyRatings{} = ratings
      assert ratings.analysts != nil
    end
  end
end
