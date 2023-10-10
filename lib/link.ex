defmodule Storyblok.Link do
  alias Storyblok.Operation

  def list(query \\ []), do: Operation.new("/v2/cdn/links", query)
end
