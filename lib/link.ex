defmodule Storyblok.Link do
  alias Storyblok.Operation

  def list(query \\ []), do: Operation.new("/links", query)
end
