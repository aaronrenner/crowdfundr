defmodule CFEmails.DefaultImpl do
  @moduledoc false

  alias CFEmails.DefaultImpl.Mailer
  alias CFEmails.DefaultImpl.UserEmail

  @behaviour CFEmails.Impl

  @type email_address :: CFEmails.email_address()

  @impl true
  @spec send_welcome(email_address) :: :ok
  def send_welcome(email_address) do
    email_address |> UserEmail.welcome() |> Mailer.deliver()
    :ok
  end
end
