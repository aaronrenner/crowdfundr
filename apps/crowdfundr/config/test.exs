use Mix.Config

# Configure your database
config :crowdfundr, Crowdfundr.DefaultImpl.Accounts.DefaultImpl.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "crowdfundr_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :argon2_elixir,
  t_cost: 1,
  m_cost: 8

config :crowdfundr, Crowdfundr.DefaultImpl.Emails.DefaultImpl.Mailer,
  adapter: Swoosh.Adapters.Test

config :crowdfundr, Crowdfundr.DefaultImpl.Emails.BambooImpl.Mailer,
  adapter: Bamboo.TestAdapter

config :constantizer, resolve_at_compile_time: false
