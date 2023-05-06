defmodule Storyblok.MixProject do
  use Mix.Project

  def project do
    [
      app: :storyblok,
      version: "0.1.0-alpha-1",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def package do
    [
      description: "Storyblok API Client",
      licenses: ["MIT"],
      links: %{GitHub: "https://github.com/christopherlai/storyblok"},
      source_url: "https://github.com/christopherlai/storyblok"
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.3.6"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
