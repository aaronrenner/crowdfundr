defmodule Crowdfundr.Mixfile do
  use Mix.Project

  def project do
    [
      app: :crowdfundr,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Crowdfundr.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:cf_accounts, in_umbrella: true},
      {:cf_emails, in_umbrella: true},
      {:cf_metrics, in_umbrella: true},
      {:constantizer, "~> 0.2.0"},
      {:crowdfundr_core, in_umbrella: true},
      {:jason, "~> 1.1"},
      {:mox, "~> 0.3", only: :test},
      {:stream_data, "~> 0.1", only: :test}
    ]
  end
end
