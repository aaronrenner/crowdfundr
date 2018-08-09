defmodule Crowdfundr.DefaultImpl.Emails.BambooImplTest do
  use ExUnit.Case, async: true
  use Bamboo.Test

  alias Crowdfundr.DefaultImpl.Emails.BambooImpl
  alias Crowdfundr.DefaultImpl.Emails.BambooImpl.UserEmails

  test "send_welcome/1 sends an email to the email address" do
    email = "aaron@example.com"

    :ok = BambooImpl.send_welcome(email)

    assert_delivered_email UserEmails.welcome(email)
  end
end
