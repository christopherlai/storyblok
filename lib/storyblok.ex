defmodule Storyblok do
  @moduledoc """
  Documentation for `Storyblok`.
  """

  alias Storyblok.Operation

  def request(operation, opts \\ []) do
    token = opts[:token] || Application.get_env(:storyblok, :token)

    unless token, do: raise(ArgumentError, "Missing token")

    operation = Operation.put_token(operation, token)

    Req.get!(Operation.url(operation), params: Operation.query(operation), follow_redirects: true)
  end
end
