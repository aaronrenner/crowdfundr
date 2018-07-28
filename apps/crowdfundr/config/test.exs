use Mix.Config

# Configure your database
config :crowdfundr, Crowdfundr.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "crowdfundr_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :argon2_elixir,
  t_cost: 1,
  m_cost: 8

config :crowdfundr, Crowdfundr.Mailer,
  adapter: Swoosh.Adapters.Test
