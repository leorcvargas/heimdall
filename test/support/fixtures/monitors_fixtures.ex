defmodule Heimdall.MonitorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Heimdall.Accounts` context.
  """

  def unique_url, do: "https://mysite#{System.unique_integer()}.com"
  def valid_reference_id, do: "#{System.unique_integer()}#{System.unique_integer()}"

  def monitor_fixture(attrs \\ %{}, user) do
    {:ok, monitor} =
      attrs
      |> Enum.into(%{
        url: unique_url(),
        reference_id: valid_reference_id()
      })
      |> Heimdall.Monitors.create_monitor(user)

    monitor
  end
end
