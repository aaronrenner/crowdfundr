defmodule CFEmails.Impl do
  @moduledoc false

  @type email_address :: CFEmails.email_address()

  @callback send_welcome(email_address) :: :ok
end
