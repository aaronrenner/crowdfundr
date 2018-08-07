defmodule Crowdfundr.Accounts do
  @moduledoc false

  import Ecto.Query, warn: false

  alias Comeonin.Argon2
  alias Crowdfundr.Accounts
  alias Crowdfundr.EmailAlreadyRegisteredError
  alias Crowdfundr.InvalidDataError
  alias Crowdfundr.Repo
  alias Crowdfundr.User
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
  def get_user!(id), do: Accounts.User |> Repo.get!(id) |> to_domain

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

  """
  @spec create_user(map) :: {:ok, User.t()} | {:error, EmailAlreadyRegisteredError.t() | InvalidDataError.t()}
  def create_user(attrs \\ %{}) do
    case %Accounts.User{} |> Accounts.User.changeset(attrs) |> Repo.insert() do
      {:ok, user} ->
        {:ok, to_domain(user)}

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
    case Accounts.User |> with_email(email) |> Repo.one do
      %Accounts.User{password_hash: hash} = user ->
        if Argon2.checkpw(password, hash) do
          {:ok, to_domain(user)}
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

  defp to_domain(%Accounts.User{id: id, email: email}) do
    %User{id: id, email: email}
  end
end
