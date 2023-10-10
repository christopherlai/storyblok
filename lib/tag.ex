defmodule Storyblok.Tag do
  alias Storyblok.Operation

  def list(query \\ []), do: Operation.new("/v2/cdn/tags", query)
end
