defmodule CFEmails.BambooImplTest do
  use ExUnit.Case, async: true
  use Bamboo.Test

  alias CFEmails.BambooImpl
  alias CFEmails.BambooImpl.UserEmails

  test "send_welcome/1 sends an email to the email address" do
    email = "aaron@example.com"

    :ok = BambooImpl.send_welcome(email)

    assert_delivered_email(UserEmails.welcome(email))
  end
end
