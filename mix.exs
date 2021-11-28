defmodule Churn.MixProject do
  use Mix.Project

  @source_url "https://github.com/patrykwozinski/churn"
  @version "0.1.10"

  def project do
    [
      app: :churn,
      description: "Churn supports finding refactoring candidates in your code",
      version: @version,
      elixir: "~> 1.8",
      escript: [main_module: Churn.CLI],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs(),
      dialyzer: [
        plt_add_deps: :apps_direct,
        plt_add_apps: [:mix],
        plt_ignore_apps: [:logger]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :typed_struct, :table_rex]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.26.0", only: :dev, runtime: false},
      {:table_rex, "~> 3.1.1"},
      {:typed_struct, "~> 0.2"}
    ]
  end

  defp docs do
    [
      extras: [
        "HOW_TO_RELEASE.md": [title: "How to Release"],
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README*),
      licenses: ["MIT"],
      links: %{
        "Changelog" => "#{@source_url}/commits/master",
        "GitHub" => @source_url
      }
    ]
  end
end
