defmodule Storyblok.Datasource do
  alias Storyblok.Operation

  def list(query \\ []) do
    Operation.new(:get, "/v2/cdn/datasources", query)
  end

  def entries(query \\ []) do
    Operation.new(:get, "/v2/cdn/datasource_entries", query)
  end
end
