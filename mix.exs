defmodule No.Mixfile do
  use Mix.Project

  @description"""
  This is `no` command that outputs `n` implemented in Elixir.
  """

  def project do
    [
      app: :no,
      version: "0.1.0",
      elixir: "~> 1.5",
      name: "No",
      description: @description,
      package: package(),
      escript: escript_config(),
      start_permanent: Mix.env == :prod,
      deps: deps()
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
      maintainers: ["tokoyax"],
      licenses: ["MIT"],
      links: %{ "Github": "https://github.com/tokoyax/no" }
    ]
  end

  defp escript_config do
    [
      main_module: No
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
