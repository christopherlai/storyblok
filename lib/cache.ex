defmodule Storyblok.Cache do
  @type json :: binary()
  @callback fetch(key :: binary(), opts :: keyword()) :: {:ok, json()} | {:error, :not_found}

  @callback set(key :: binary(), value :: json(), opts :: keyword()) :: :ok | {:error, any()}

  def fetch(key, opts \\ []) do
    key =
      opts
      |> Keyword.get(:prefix)
      |> join_key(key)

    opts = Keyword.get(opts, :store_opts, [])

    with {:ok, json} <- store().get(key, opts) do
      Jason.decode(json)
    end
  end

  def set(key, value, opts \\ []) do
    key =
      opts
      |> Keyword.get(:prefix)
      |> join_key(key)

    opts = Keyword.get(opts, :store_opts, [])

    with {:ok, json} <- Jason.encode(value) do
      store().set(key, json, opts)
    end
  end

  def get_cache_version(opts \\ []) do
    key =
      opts
      |> Keyword.get(:prefix)
      |> join_key("storyblok:cv")

    opts = Keyword.get(opts, :store_opts, [])

    case store().fetch(key, opts) do
      {:ok, version} -> version
      {:error, :not_found} -> 0
    end
  end

  def set_cache_version(version, opts \\ []) do
    key =
      opts
      |> Keyword.get(:prefix)
      |> join_key("storyblok:cv")

    opts = Keyword.get(opts, :store_opts, [])

    store().set(key, version, opts)
  end

  defp store, do: Application.get_env(:storyblok, :cache_store, Storyblok.RedisCache)

  defp join_key(nil, suffix), do: suffix
  defp join_key(prefix, suffix), do: prefix <> ":" <> suffix
end
