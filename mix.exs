defmodule Churn.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :churn,
      description: "Churn supports finding refactoring candidates in your code",
      version: @version,
      elixir: "~> 1.11",
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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:typed_struct, "~> 0.1"},
      {:table_rex, "~> 3.1.1"},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/patrykwozinski/churn"}
    ]
  end
end
