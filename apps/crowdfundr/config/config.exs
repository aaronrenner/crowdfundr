use Mix.Config

config :crowdfundr, ecto_repos: [Crowdfundr.DefaultImpl.Accounts.DefaultImpl.Repo]

import_config "#{Mix.env()}.exs"
