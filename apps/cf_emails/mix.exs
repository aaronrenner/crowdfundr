defmodule CFEmails.MixProject do
  use Mix.Project

  def project do
    [
      app: :cf_emails,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bamboo, "~> 1.0"},
      {:constantizer, "~> 0.2.0"},
      {:swoosh, "~> 0.16"},
      {:mox, "~> 0.3", only: :test},
      {:stream_data, "~> 0.1", only: :test}
    ]
  end
end
