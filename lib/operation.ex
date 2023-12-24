defmodule Storyblok.Operation do
  defstruct base: "https://api.storyblok.com/v2",
            method: :get,
            path: nil,
            query: [],
            token: nil,
            bypass: false

  @default_query [version: "published"]

  def new(path, query \\ []) do
    query = Keyword.merge(@default_query, query)
    struct!(__MODULE__, path: path, query: query)
  end

  def put_token(%__MODULE__{} = operation, token), do: %{operation | token: token}

  def url(%__MODULE__{} = operation) do
    (operation.base <> operation.path)
    |> URI.parse()
    |> URI.to_string()
  end

  def query_encode(%__MODULE__{query: query, token: token}, cv) do
    encode = [
      token: token,
      version: query[:version],
      cv: cv
    ]

    encode
    |> URI.encode_query()
    |> Base.url_encode64()
  end

  def query(%__MODULE__{query: query, token: token}), do: query ++ [token: token]

  def cache?(%__MODULE__{bypass: bypass, query: query}),
    do: !bypass && query[:version] == "published"
end
