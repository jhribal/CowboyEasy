defmodule CowboyEasy.Mixfile do
  use Mix.Project

  def project do
    [app: :cowboy_easy,
     version: "0.0.1",
     elixir: "~> 0.15.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:earmark, "~> 0.1", only: [:dev, :test]}, 
     {:ex_doc, "~> 0.5", only: [:dev, :test]}]
  end
end
