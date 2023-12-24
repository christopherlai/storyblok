defmodule Storyblok.MixProject do
  use Mix.Project

  def project do
    [
      app: :storyblok,
      version: "2023.12.24-beta.1",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      description: "Storyblok API Client",
      licenses: ["MIT"],
      links: %{GitHub: "https://github.com/christopherlai/storyblok"},
      source_url: "https://github.com/christopherlai/storyblok"
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:jason, "~> 1.4"},
      {:redix, "~> 1.3", optional: true},
      {:req, "~> 0.3.6", optional: true}
    ]
  end
end
