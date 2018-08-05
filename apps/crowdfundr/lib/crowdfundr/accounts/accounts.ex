defmodule Crowdfundr.Accounts do
  @moduledoc false

  import Ecto.Query, warn: false

  alias Comeonin.Argon2
  alias Crowdfundr.Accounts.User
  alias Crowdfundr.EmailAlreadyRegisteredError
  alias Crowdfundr.InvalidDataError
  alias Crowdfundr.Repo
  alias Ecto.Changeset

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_user(map) :: {:ok, User.t()} | {:error, EmailAlreadyRegisteredError.t() | InvalidDataError.t()}
  def create_user(attrs \\ %{}) do
    case %User{} |> User.changeset(attrs) |> Repo.insert() do
      {:ok, user} ->
        {:ok, user}

      {:error, %Changeset{errors: errors} = changeset} ->
        if {:email, {"is_already_registered", []}} in errors do
          {:error, EmailAlreadyRegisteredError.exception(email: Changeset.get_change(changeset, :email))}
        else
          {:error, InvalidDataError.exception(errors: errors)}
        end
    end
  end

  @spec fetch_by_email_and_password(String.t(), String.t()) :: {:ok, User.t()} | {:error, :not_found}
  def fetch_by_email_and_password(email, password) when is_binary(email) and is_binary(password) do
    case User |> with_email(email) |> Repo.one do
      %User{password_hash: hash} = user ->
        if Argon2.checkpw(password, hash) do
          {:ok, user}
        else
          {:error, :not_found}
        end
      nil ->
        Argon2.dummy_checkpw()
        {:error, :not_found}
    end
  end

  defp with_email(query, email) do
    from(u in query, where: u.email == ^email)
  end
end
