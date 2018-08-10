defmodule CFEmails.DefaultImpl.Mailer do
  @moduledoc false
  use Swoosh.Mailer, otp_app: :cf_emails
end
