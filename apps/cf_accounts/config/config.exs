use Mix.Config

config :cf_accounts, ecto_repos: [CFAccounts.DefaultImpl.Repo]

import_config "#{Mix.env()}.exs"
