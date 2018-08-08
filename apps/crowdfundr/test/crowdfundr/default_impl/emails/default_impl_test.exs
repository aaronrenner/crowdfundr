defmodule Crowdfundr.DefaultImpl.Emails.DefaultImplTest do
  use ExUnit.Case, async: true

  import Swoosh.TestAssertions

  alias Crowdfundr.DefaultImpl.Emails.DefaultImpl
  alias Crowdfundr.DefaultImpl.Emails.DefaultImpl.UserEmail

  test "send_welcome/1 sends the appropriate email" do
    email = "foo@example.com"

    assert :ok = DefaultImpl.send_welcome(email)

    assert_email_sent UserEmail.welcome(email)
  end
end
