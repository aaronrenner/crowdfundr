use Mix.Config

config :crowdfundr, ecto_repos: [Crowdfundr.DefaultImpl.Accounts.DefaultImpl.Repo]

config :crowdfundr, Crowdfundr.DefaultImpl.Emails.DefaultImpl.Mailer,
  adapter: Swoosh.Adapters.Logger

config :crowdfundr, Crowdfundr.DefaultImpl.Emails.BambooImpl.Mailer,
  adapter: Bamboo.LocalAdapter

import_config "#{Mix.env}.exs"
