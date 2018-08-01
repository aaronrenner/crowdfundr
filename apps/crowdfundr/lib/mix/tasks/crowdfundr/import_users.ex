defmodule Mix.Tasks.Crowdfundr.ImportUsers do
  @moduledoc false
  use Mix.Task

  alias Crowdfundr.Accounts
  alias Crowdfundr.Accounts.User
  alias Crowdfundr.Mailer
  alias Crowdfundr.Statix
  alias Crowdfundr.UserEmail
  alias Ecto.Changeset

  @shortdoc "Import users from a list of usernames and passwords"
  def run(args) do
    with {:ok, filename} <- parse_args(args) do
      import_users(filename)
    else
      error ->
        handle_error(error)
    end
  end

  def import_users(filename) do
    filename
    |> File.read!()
    |> Jason.decode!(strings: :copy)
    |> Enum.map(fn user_params ->
      {:ok, _} = register_user(user_params)
    end)
  end

  @spec register_user(map) :: {:ok, User.t()} | {:error, Changeset.t()}
  defp register_user(user_params) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        # Send welcome email
        user.email |> UserEmail.welcome |> Mailer.deliver

        # Send event to statsd
        Statix.increment("user_registered")

        {:ok, user}

      {:error, %Changeset{} = changeset} ->
        {:error, changeset}
    end
  end

  defp parse_args(args) do
    case OptionParser.parse(args, strict: []) do
      {_, [filename], []} ->
        {:ok, filename}
      _ ->
        {:error, :invalid_args}
    end
  end

  defp handle_error({:error, :invalid_args}) do
    IO.puts """
    Invalid arguments.

      mix crowdfundr.import_users <filename>
    """
    exit({:shutdown, 1})
  end
end
