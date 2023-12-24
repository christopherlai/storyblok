defmodule Storyblok.Cache do
  @moduledoc """
  This callback must be implemented to utilize caching.

  Implement `c:fetch/2` and `c:set/4` and add the following to your config.

  ```elixir
  config :storyblok, cache: true, cache_store: MyApp.CacheStore
  ```
  """

  @typedoc "Valid JSON"
  @type json :: binary()

  @doc "Callback for getting data for key from cache store/"
  @callback fetch(key :: binary(), opts :: keyword()) :: {:ok, json()} | {:error, :not_found}

  @doc "Callback for setting data with the given key. expire_in_ms is the TTL for the key in milliseconds."
  @callback set(key :: binary(), value :: json(), expire_in_ms :: integer(), opts :: keyword()) ::
              :ok | {:error, any()}

  @doc false
  def fetch(token, path, query, opts \\ []) do
    cv = get_cache_version(token, opts)
    key = "storyblok:#{token}:v:#{cv}:#{path}:#{query}"

    with {:ok, json} <- store().fetch(key, opts) do
      Jason.decode(json)
    end
  end

  @doc false
  def set(token, path, query, value, opts \\ []) do
    cv = get_cache_version(token, opts)
    key = "storyblok:#{token}:v:#{cv}:#{path}:#{query}"
    expire = :timer.hours(1)

    with {:ok, json} <- Jason.encode(value) do
      store().set(key, json, expire, opts)
    end
  end

  @doc false
  def get_cache_version(token, opts \\ []) do
    key = "storyblok:#{token}:version"

    case store().fetch(key, opts) do
      {:ok, version} -> version
      {:error, :not_found} -> DateTime.utc_now() |> DateTime.to_unix()
    end
  end

  @doc false
  def set_cache_version(token, version, opts \\ []) do
    key = "storyblok:#{token}:version"

    store().set(key, version, opts)
  end

  defp store, do: Application.get_env(:storyblok, :cache_store, Storyblok.RedisCache)
end
