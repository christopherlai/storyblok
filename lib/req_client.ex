defmodule Storyblok.ReqClient do
  @behaviour Storyblok.Client

  @impl true
  def execute(url, query, opts) do
    opts =
      opts
      |> Keyword.put(:params, query)
      |> Keyword.put_new(:redirect, true)

    case Req.get(url, opts) do
      {:ok, response} ->
        {:ok,
         %{
           status: response.status,
           headers: response.headers,
           body: response.body,
           client_opts: [private: response.private]
         }}

      other ->
        other
    end
  end
end
