defmodule CFEmails.BambooImpl do
  @moduledoc false

  alias CFEmails.BambooImpl.Mailer
  alias CFEmails.BambooImpl.UserEmails

  @behaviour CFEmails.Impl

  @type email_address :: CFEmails.email_address()

  @impl true
  @spec send_welcome(email_address) :: :ok
  def send_welcome(email_address) do
    email_address |> UserEmails.welcome() |> Mailer.deliver_now()

    :ok
  end
end
