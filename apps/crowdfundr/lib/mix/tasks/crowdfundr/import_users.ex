defmodule Mix.Tasks.Crowdfundr.ImportUsers do
  @moduledoc false
  use Mix.Task

  alias Crowdfundr.User

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
      {:ok, %User{}} = Crowdfundr.register_user(user_params)
    end)
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
    IO.puts("""
    Invalid arguments.

      mix crowdfundr.import_users <filename>
    """)

    exit({:shutdown, 1})
  end
end
