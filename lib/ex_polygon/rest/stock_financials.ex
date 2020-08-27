defmodule ExPolygon.Rest.StockFinancials do
  @type financial :: ExPolygon.Financial.t()
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type shared_error_reasons :: ExPolygon.Rest.HTTPClient.shared_error_reasons()

  @path "/v2/reference/financials/:symbol"

  # params is a string format map, that contains possible parameters
  # for the call, like %{"limit" => 3, "sort" => "calendarDate"} etc
  @spec query(String.t(), map, api_key) :: {:ok, [financial]} | {:error, shared_error_reasons}
  def query(symbol, params \\ %{}, api_key) do
    with {:ok, data} <-
           @path
           |> String.replace(":symbol", symbol)
           |> ExPolygon.Rest.HTTPClient.get(params, api_key) do
      parse_response(data)
    end
  end

  defp parse_response(%{"status" => "OK", "results" => results}) do
    financials =
      results
      |> Enum.map(&Mapail.map_to_struct(&1, ExPolygon.Financial, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, financials}
  end
end
