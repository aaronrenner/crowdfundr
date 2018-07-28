use Mix.Config

config :crowdfundr, ecto_repos: [Crowdfundr.Repo]

config :crowdfundr, Crowdfundr.Mailer,
  adapter: Swoosh.Adapters.Logger

import_config "#{Mix.env}.exs"
