use Mix.Config

# Configure your database
config :cf_accounts, CFAccounts.DefaultImpl.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "crowdfundr_dev",
  hostname: "localhost",
  pool_size: 10
