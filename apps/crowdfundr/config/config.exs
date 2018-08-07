use Mix.Config

config :crowdfundr, ecto_repos: [Crowdfundr.DefaultImpl.Accounts.Repo]

config :crowdfundr, Crowdfundr.DefaultImpl.Mailer,
  adapter: Swoosh.Adapters.Logger

import_config "#{Mix.env}.exs"
