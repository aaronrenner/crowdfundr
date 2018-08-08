defmodule Crowdfundr.DefaultImpl.Emails.Impl do
  @moduledoc false

  alias Crowdfundr.DefaultImpl.Emails

  @type email_address :: Emails.email_address()

  @callback send_welcome(email_address) :: :ok
end
