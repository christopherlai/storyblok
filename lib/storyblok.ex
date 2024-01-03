defmodule Storyblok do
  @moduledoc """
  Documentation for `Storyblok`.
  """

  alias Storyblok.Operation
  alias Storyblok.Client
  alias Storyblok.Cache

  def request(operation, opts \\ []) do
    token = opts[:token] || Application.get_env(:storyblok, :token)

    unless token, do: raise(ArgumentError, "Missing token")

    operation = Operation.put_token(operation, token)
    cache = Application.get_env(:storyblok, :cache, false) && Operation.cache?(operation)

    request_fun = fn ->
      Client.execute(
        Operation.url(operation),
        Operation.query(operation),
        Keyword.get(opts, :client_opts, [])
      )
    end

    if cache do
      token = operation.token
      path = operation.path
      cv = Cache.get_cache_version(token)
      encoded_query = Operation.query_encode(operation, cv)
      opts = Keyword.get(opts, :cache_opts, [])

      with {:error, _error} <- Cache.fetch(token, path, encoded_query, opts),
           {:ok, %{status: 200} = response} <- request_fun.() do
        data = %{
          "headers" => Enum.into(response.headers, %{}),
          "data" => response.body
        }

        cv = get_in(data, ["data", "cv"])
        Cache.set_cache_version(token, cv, opts)
        Cache.set(token, path, encoded_query, data, opts)

        {:ok, data}
      end
    else
      with {:ok, %{status: 200} = response} <- request_fun.() do
        data = %{
          "headers" => Enum.into(response.headers, %{}),
          "data" => response.body
        }

        {:ok, data}
      end
    end
  end
end
