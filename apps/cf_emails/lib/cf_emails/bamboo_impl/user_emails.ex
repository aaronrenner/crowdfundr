defmodule CFEmails.BambooImpl.UserEmails do
  @moduledoc false

  import Bamboo.Email

  @from_email "crowdfundr@example.com"

  def welcome(email) do
    new_email()
    |> to(email)
    |> from(@from_email)
    |> subject("Welcome to Crowdfundr!")
    |> html_body("<h1>Thanks for signing up for Crowdfundr, #{email}!</h1>")
  end
end
