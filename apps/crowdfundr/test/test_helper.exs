ExUnit.start()

Mox.defmock(Crowdfundr.MockCrowdfundr, for: Crowdfundr.Impl)
Application.put_env(:crowdfundr, :impl, Crowdfundr.MockCrowdfundr)

Mox.defmock(Crowdfundr.MockMetrics, for: CFMetrics.Impl)
Application.put_env(:cf_metrics, :impl, Crowdfundr.MockMetrics)

Mox.defmock(Crowdfundr.MockAccounts, for: CFAccounts.Impl)
Application.put_env(:cf_accounts, :impl, Crowdfundr.MockAccounts)

Mox.defmock(Crowdfundr.MockCFEmails, for: CFEmails.Impl)
Application.put_env(:cf_emails, :impl, Crowdfundr.MockCFEmails)
