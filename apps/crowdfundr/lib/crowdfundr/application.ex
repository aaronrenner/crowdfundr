defmodule Crowdfundr.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Crowdfundr.DefaultImpl.Accounts.DefaultImpl.Repo, []),
    ], strategy: :one_for_one, name: Crowdfundr.Supervisor)
  end
end
