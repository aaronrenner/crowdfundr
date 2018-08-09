use Mix.Config

config :crowdfundr, ecto_repos: [Crowdfundr.DefaultImpl.Accounts.DefaultImpl.Repo]

config :crowdfundr, Crowdfundr.DefaultImpl.Emails.DefaultImpl.Mailer,
  adapter: Swoosh.Adapters.Logger

import_config "#{Mix.env}.exs"
