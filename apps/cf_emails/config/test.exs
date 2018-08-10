use Mix.Config

config :cf_emails, CFEmails.DefaultImpl.Mailer, adapter: Swoosh.Adapters.Test

config :cf_emails, CFEmails.BambooImpl.Mailer, adapter: Bamboo.TestAdapter
