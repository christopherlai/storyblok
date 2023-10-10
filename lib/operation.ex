defmodule Storyblok.Operation do
  defstruct base: "https://api.storyblok.com",
            method: :get,
            path: nil,
            query: [],
            token: nil

  def new(path, query \\ []), do: struct!(__MODULE__, path: path, query: query)

  def put_token(%__MODULE__{} = operation, token), do: %{operation | token: token}

  def url(%__MODULE__{} = operation) do
    (operation.base <> operation.path)
    |> URI.parse()
    |> URI.to_string()
  end

  def query(%__MODULE__{query: query, token: token}), do: query ++ [token: token]
end
