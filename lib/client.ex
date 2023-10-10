defmodule Storyblok.Client do
  @callback execute(url :: binary(), query :: keyword(), opts :: keyword()) ::
              {:ok, %{status: pos_integer(), headers: keyword(), body: any(), client_opts: any()}}
              | {:error, any}

  def execute(url, query, opts \\ []), do: client().execute(url, query, opts)

  defp client, do: Application.get_env(:storyblok, :client, Storyblok.ReqClient)
end
