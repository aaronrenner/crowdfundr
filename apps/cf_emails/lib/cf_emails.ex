defmodule CFEmails do
  @moduledoc """
  Internal API for working with emails in the Crowdfundr app.
  """

  import Constantizer

  alias CFEmails.BambooImpl

  @behaviour CFEmails.Impl

  @type email_address :: String.t()

  @doc """
  Sends the welcome email to the given email address.
  """
  @impl true
  @spec send_welcome(email_address) :: :ok
  def send_welcome(email_address) do
    impl().send_welcome(email_address)
  end

  defconstp impl do
    Application.get_env(:cf_emails, :impl, BambooImpl)
  end
end
