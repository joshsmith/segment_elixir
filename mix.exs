defmodule AnalyticsElixir.Mixfile do
  use Mix.Project

  def project do
    [
      app: :segment,
      version: "2.0.0-rc.1",
      elixir: "~> 1.8.1",
      deps: deps(),
      description: "segment_elixir",
      package: package(),
      preferred_cli_env: [
        vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test
      ],
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {Segment.Application, []},
      extra_applications: [:logger],
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.5.1"},
      {:jason, "~> 1.1"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false},
      {:exvcr, "~> 0.10", only: :test},
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Josh Smith"],
      licenses: ["MIT"],
      links: %{ "GitHub" => "https://github.com/joshsmith/segment_elixir" }
    ]
  end
end
