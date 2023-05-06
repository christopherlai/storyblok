defmodule Storyblok.Tag do
  alias Storyblok.Operation

  def list(query \\ []) do
    Operation.new(:get, "/v2/cdn/tags", query)
  end
end
