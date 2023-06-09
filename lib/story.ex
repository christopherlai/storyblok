defmodule Storyblok.Story do
  alias Storyblok.Operation

  @typep story_identifier :: full_slug() | id() | uuid()

  @typep full_slug :: binary()
  @typep id :: binary()
  @typep uuid :: binary()

  @spec get(identifier :: story_identifier()) :: term()
  def get(identifier, query \\ []) do
    Operation.new(:get, "/v2/cdn/stories/#{identifier}", query)
  end

  def list(query \\ []) do
    Operation.new(:get, "/v2/cdn/stories", query)
  end
end
