defmodule Storyblok.Datasource do
  alias Storyblok.Operation

  def list(query \\ []), do: Operation.new("/cdn/datasources", query)

  def entries(query \\ []), do: Operation.new("/cdn/datasource_entries", query)
end
