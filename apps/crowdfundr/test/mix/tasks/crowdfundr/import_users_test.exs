defmodule Mix.Tasks.Crowdfundr.ImportUsersTest do
  use Crowdfundr.DataCase, async: true

  import Swoosh.TestAssertions

  alias Crowdfundr.Accounts
  alias Crowdfundr.UserEmail
  alias Mix.Tasks.Crowdfundr.ImportUsers

  setup :create_tmp_dir

  test "run/1 creates users from the given usernames and passwords", %{tmp_dir: tmp_dir} do
    filename = Path.join(tmp_dir, "test.json")
    json_data = Jason.encode_to_iodata!([
      %{"email" => "user1@example.com", "password" => "secret"},
      %{"email" => "user2@example.com", "password" => "password"}
    ])
    File.write!(filename, json_data)

    ImportUsers.run([filename])

    assert Accounts.list_users() |> length == 2
    assert_email_sent UserEmail.welcome("user1@example.com")
    assert_email_sent UserEmail.welcome("user2@example.com")
    # How do we test the metrics are sent?
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
