defmodule Crowdfundr.UserEmail do
  @moduledoc """
  Emails that can be sent to users.
  """
  import Swoosh.Email

  @from_email "crowdfundr@example.com"

  def welcome(email) do
    new()
    |> to(email)
    |> from(@from_email)
    |> subject("Welcome to Crowdfundr!")
    |> html_body("<h1>Thanks for signing up for Crowdfundr, #{email}!</h1>")
  end
end
