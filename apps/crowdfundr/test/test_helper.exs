ExUnit.start()

Mox.defmock(Crowdfundr.MockCrowdfundr, for: Crowdfundr.Impl)
Application.put_env(:crowdfundr, :impl, Crowdfundr.MockCrowdfundr)

Ecto.Adapters.SQL.Sandbox.mode(Crowdfundr.DefaultImpl.Accounts.Repo, :manual)
