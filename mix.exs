defmodule AnalyticsElixir.Mixfile do
  use Mix.Project

  def project do
    [
      app: :segment,
      deps: deps(),
      description: description(),
      dialyzer: [
        plt_add_apps: [:mix],
        plt_add_deps: :app_tree,
        plt_file: {:no_warn, "priv/plts/segment_elixir.plt"},
      ],
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        vcr: :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test
      ],
      source_url: "https://github.com/joshsmith/segment_elixir/",
      test_coverage: [tool: ExCoveralls],
      version: "2.0.0-rc.1",
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      applications: apps(Mix.env()),
      mod: {Segment, []},
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib"]
  defp elixirc_paths(_), do: ["lib"]

  defp apps(:test), do: apps()
  defp apps(_), do: apps()
  defp apps(), do: [:logger]

  defp deps do
    [
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:excoveralls, "~> 0.8.1", only: :test},
      {:exvcr, "~> 0.10", only: :test},
      {:httpoison, "~> 1.5.1"},
      {:inch_ex, "~> 2.0", only: [:dev, :test]},
      {:jason, "~> 1.1"},
    ]
  end

  defp description, do: "Segment client for Elixir"

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Josh Smith"],
      name: "segment_elixir",
      licenses: ["MIT"],
      links: %{ "GitHub" => "https://github.com/joshsmith/segment_elixir" }
    ]
  end
end
