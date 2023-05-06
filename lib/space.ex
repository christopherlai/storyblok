defmodule Storyblok.Space do
  alias Storyblok.Operation

  def current do
    Operation.new(:get, "/v2/cdn/spaces/me/")
  end
end
