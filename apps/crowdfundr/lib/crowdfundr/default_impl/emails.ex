defmodule Crowdfundr.DefaultImpl.Emails do
  @moduledoc false

  alias Crowdfundr.DefaultImpl.Emails.DefaultImpl

  @behaviour Crowdfundr.DefaultImpl.Emails.Impl

  @type email_address :: String.t()

  @impl true
  @spec send_welcome(email_address) :: :ok
  def send_welcome(email_address) do
    impl().send_welcome(email_address)
  end

  defp impl do
    Application.get_env(:crowdfundr, :emails_impl, DefaultImpl)
  end
end
