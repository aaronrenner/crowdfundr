defmodule Crowdfundr.DefaultImpl.Metrics do
  @moduledoc false

  alias Crowdfundr.DefaultImpl.Metrics.DefaultImpl

  @behaviour Crowdfundr.DefaultImpl.Metrics.Impl

  @impl true
  @spec send_user_registered :: :ok
  def send_user_registered do
    impl().send_user_registered()
  end

  defp impl do
    Application.get_env(:crowdfundr, :metrics_impl, DefaultImpl)
  end
end
