# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :cf_emails, CFEmails.DefaultImpl.Mailer, adapter: Swoosh.Adapters.Logger

config :cf_emails, CFEmails.BambooImpl.Mailer, adapter: Bamboo.LocalAdapter

import_config "#{Mix.env()}.exs"
