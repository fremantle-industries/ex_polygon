use Mix.Config

config :exvcr,
  filter_request_headers: [],
  filter_sensitive_data: [
    [pattern: "apiKey=[A-Z0-9]+", placeholder: "apiKey=***"]
  ]
