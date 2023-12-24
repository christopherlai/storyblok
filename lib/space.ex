defmodule Storyblok.Space do
  alias Storyblok.Operation

  def current, do: Operation.new("/cdn/spaces/me/")
end
