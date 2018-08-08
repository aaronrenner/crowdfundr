ExUnit.start()

Mox.defmock(Crowdfundr.MockCrowdfundr, for: Crowdfundr.Impl)
Application.put_env(:crowdfundr, :impl, Crowdfundr.MockCrowdfundr)

Mox.defmock(Crowdfundr.MockMetrics, for: Crowdfundr.DefaultImpl.Metrics.Impl)
Application.put_env(:crowdfundr, :metrics_impl, Crowdfundr.MockMetrics)

Ecto.Adapters.SQL.Sandbox.mode(Crowdfundr.DefaultImpl.Accounts.Repo, :manual)
