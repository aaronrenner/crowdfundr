defmodule Mix.Tasks.Crowdfundr.ImportUsersTest do
  use Crowdfundr.DataCase, async: true

  import Mox

  alias Crowdfundr.MockCrowdfundr
  alias Crowdfundr.User
  alias Mix.Tasks.Crowdfundr.ImportUsers

  setup [:create_tmp_dir, :set_mox_from_context, :verify_on_exit!]

  test "run/1 creates users from the given usernames and passwords", %{tmp_dir: tmp_dir} do
    filename = Path.join(tmp_dir, "test.json")
    json_data = Jason.encode_to_iodata!([
      %{"email" => "user1@example.com", "password" => "secret"},
      %{"email" => "user2@example.com", "password" => "password"}
    ])
    File.write!(filename, json_data)

    MockCrowdfundr
    |> expect(:register_user, fn %{"email" => "user1@example.com", "password" => "secret"} ->
      {:ok, %User{email: "user1@example.com"}}
    end)
    |> expect(:register_user, fn %{"email" => "user2@example.com", "password" => "password"} ->
      {:ok, %User{email: "user2@example.com"}}
    end)

    ImportUsers.run([filename])
  end

  defp create_tmp_dir(_) do
    tmp_dir = Path.join([System.tmp_dir!(), "crowdfundr_test", random_string()])

    File.mkdir_p!(tmp_dir)
    on_exit(fn ->
      File.rm_rf!(tmp_dir)
    end)

    [tmp_dir: tmp_dir]
  end

  defp random_string(length \\ 40) do
    length
    |> :crypto.strong_rand_bytes
    |> Base.url_encode64
    |> binary_part(0, length)
  end
end
