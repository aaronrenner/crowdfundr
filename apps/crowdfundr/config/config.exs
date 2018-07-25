use Mix.Config

config :crowdfundr, ecto_repos: [Crowdfundr.Repo]

import_config "#{Mix.env}.exs"
