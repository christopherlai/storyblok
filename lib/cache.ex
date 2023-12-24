defmodule Storyblok.Cache do
  @type json :: binary()
  @callback fetch(key :: binary(), opts :: keyword()) :: {:ok, json()} | {:error, :not_found}

  @callback set(key :: binary(), value :: json(), expire_in_ms :: integer(), opts :: keyword()) ::
              :ok | {:error, any()}

  def fetch(token, path, query, opts \\ []) do
    cv = get_cache_version(token, opts)
    key = "storyblok:#{token}:v:#{cv}:#{path}:#{query}"

    with {:ok, json} <- store().fetch(key, opts) do
      Jason.decode(json)
    end
  end

  def set(token, path, query, value, opts \\ []) do
    cv = get_cache_version(token, opts)
    key = "storyblok:#{token}:v:#{cv}:#{path}:#{query}"
    expire = :timer.hours(1)

    with {:ok, json} <- Jason.encode(value) do
      store().set(key, json, expire, opts)
    end
  end

  def get_cache_version(token, opts \\ []) do
    key = "storyblok:#{token}:version"

    case store().fetch(key, opts) do
      {:ok, version} -> version
      {:error, :not_found} -> DateTime.utc_now() |> DateTime.to_unix()
    end
  end

  def set_cache_version(token, version, opts \\ []) do
    key = "storyblok:#{token}:version"

    store().set(key, version, opts)
  end

  defp store, do: Application.get_env(:storyblok, :cache_store, Storyblok.RedisCache)
end
