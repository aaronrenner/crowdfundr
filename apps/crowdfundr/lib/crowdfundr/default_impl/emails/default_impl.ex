defmodule Crowdfundr.DefaultImpl.Emails.DefaultImpl do
  @moduledoc false

  alias Crowdfundr.DefaultImpl.Emails
  alias Crowdfundr.DefaultImpl.Emails.DefaultImpl.Mailer
  alias Crowdfundr.DefaultImpl.Emails.DefaultImpl.UserEmail

  @behaviour Crowdfundr.DefaultImpl.Emails.Impl

  @type email_address :: Emails.email_address()

  @impl true
  @spec send_welcome(email_address) :: :ok
  def send_welcome(email_address) do
    email_address |> UserEmail.welcome |> Mailer.deliver
    :ok
  end
end
