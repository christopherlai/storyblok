defmodule Storyblok.Datasource do
  alias Storyblok.Operation

  def list(query \\ []), do: Operation.new("/v2/cdn/datasources", query)

  def entries(query \\ []), do: Operation.new("/v2/cdn/datasource_entries", query)
end
