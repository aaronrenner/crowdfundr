ExUnit.start()

Mox.defmock(CrowdfundrWeb.MockCrowdfundr, for: Crowdfundr.Impl)
Application.put_env(:crowdfundr, :impl, CrowdfundrWeb.MockCrowdfundr)

Ecto.Adapters.SQL.Sandbox.mode(Crowdfundr.Repo, :manual)
