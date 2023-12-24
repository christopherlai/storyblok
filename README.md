# Storyblok

## Installation

The [package]https://hex.pm/packages/storyblok) can be installed by adding `storyblok` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:storyblok, "~> 2023.12.24-beta.2"}
  ]
end
```

## Configuration

### Storyblok API Token

The Storyblok `token` can be configured 2 ways.

#### Application

To configure the `token` for your entire application, add the following to your config file.

```elixir
import Config

config :storyblok, token: "<TOKEN>"
```

#### Per Request

Alternatively, the `token` can be configured per request by passing `token` to `Storyblok.request`.

```elixir
"123"
|> Storyblok.Story.get()
|> Storyblok.request(token: "<TOKEN>")
```

## Caching

The default configuration is to disable caching, every request hits the Storyblok API.

Caching can be enabled by setting the follow configs.

```elixir
import Config

config :storyblok, cache: true, cache_store: MyApp.CacheModule
```

Any store can be used for caching (Redis, MemCached, etc), your application must implement the `Storyblok.Cache` behaviour.

```elixir
defmodule MyApp.CacheModule do
  def fetch(key, opts) do
    case MyApp.get(key, opts) do
      {:ok, data} -> {:ok, data}
      {:error, _reason} -> {:error, :not_found}
    end
  end

  def set(key, value, expire_in_ms, opts) do
    case MyApp.set(key, value, expire_in_ms, opts) do
      {:ok, _data} -> :ok
      {:error, reason} -> {:error, reason}
    end
  end
end
```
