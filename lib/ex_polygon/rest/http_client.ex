defmodule ExPolygon.Rest.HTTPClient do
  @endpoint :ex_alpaca |> Application.get_env(:endpoint, "https://api.polygon.io") |> URI.parse()

  def get(path, params, api_key) do
    query_params = params |> Map.put(:apiKey, api_key)
    path |> get(query_params)
  end

  def get(path, query_params) do
    path
    |> url(query_params)
    |> HTTPoison.get()
    |> parse_response
  end

  def url(path, query), do: %URI{path: path, query: query |> URI.encode_query()} |> url()
  def url(%URI{} = u), do: @endpoint |> URI.merge(u) |> URI.to_string()

  defp parse_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    data = Jason.decode!(body)
    {:ok, data}
  end
end
