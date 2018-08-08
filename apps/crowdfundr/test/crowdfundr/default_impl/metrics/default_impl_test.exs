defmodule Crowdfundr.DefaultImpl.Metrics.DefaultImplTest do
  use ExUnit.Case, async: true

  alias Crowdfundr.DefaultImpl.Metrics.DefaultImpl

  test "returns :ok" do
    assert :ok = DefaultImpl.send_user_registered()
  end
end
