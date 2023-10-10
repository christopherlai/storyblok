defmodule Storyblok do
  @moduledoc """
  Documentation for `Storyblok`.
  """

  alias Storyblok.Operation
  alias Storyblok.Client

  def request(operation, opts \\ []) do
    token = opts[:token] || Application.get_env(:storyblok, :token)

    unless token, do: raise(ArgumentError, "Missing token")

    operation = Operation.put_token(operation, token)

    Client.execute(
      Operation.url(operation),
      Operation.query(operation),
      Keyword.get(opts, :client_opts, [])
    )
  end
end
