defmodule ExPolygon.News do
  @type t :: %ExPolygon.News{}

  defstruct ~w(
    symbols
    title
    url
    source
    summary
    image
    timestamp
    keywords
  )a
end
