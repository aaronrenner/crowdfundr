defmodule Crowdfundr.DefaultImpl.Emails.BambooImpl do
  @moduledoc false

  alias Crowdfundr.DefaultImpl.Emails
  alias Crowdfundr.DefaultImpl.Emails.BambooImpl.Mailer
  alias Crowdfundr.DefaultImpl.Emails.BambooImpl.UserEmails

  @behaviour Crowdfundr.DefaultImpl.Emails.Impl

  @type email_address :: Emails.email_address()

  @impl true
  @spec send_welcome(email_address) :: :ok
  def send_welcome(email_address) do
    email_address |> UserEmails.welcome() |> Mailer.deliver_now

    :ok
  end
end
