defmodule Heimdall.MonitorsTest do
  use Heimdall.DataCase

  import Heimdall.AccountsFixtures
  import Heimdall.MonitorsFixtures
  alias Heimdall.Monitors
  alias Heimdall.Monitors.{Monitor}

  @insert_attrs %{
    name: "some name",
    reference_id: "some reference_id",
    url: "https://monitor.com"
  }
  @update_attrs %{
    name: "some updated name",
    reference_id: "some updated reference_id",
    url: "https://diffmonitor.com"
  }
  @invalid_attrs %{name: nil, reference_id: nil, url: nil}

  describe "create_monitor/2" do
    test "with valid data creates a monitor" do
      user = user_fixture()

      assert {:ok, %Monitor{} = monitor} = Monitors.create_monitor(@insert_attrs, user)
      assert monitor.name == @insert_attrs.name
      assert monitor.reference_id == "some reference_id"
      assert monitor.url == @insert_attrs.url
    end

    test "with invalid URL returns error changeset" do
      user = user_fixture()

      invalid_url_attrs = %{@insert_attrs | url: "leovargas.dev"}

      assert {:error, %Ecto.Changeset{}} = Monitors.create_monitor(invalid_url_attrs, user)
    end

    test "with invalid data returns error changeset" do
      user = user_fixture()

      assert {:error, %Ecto.Changeset{}} = Monitors.create_monitor(@invalid_attrs, user)
    end
  end

  describe "list_monitors/0" do
    test "returns all monitors" do
      user = user_fixture()
      monitor = monitor_fixture(%{}, user)
      assert Monitors.list_monitors() == [monitor]
    end
  end

  describe "get_monitor!/1" do
    test "returns the monitor with given id" do
      user = user_fixture()
      monitor = monitor_fixture(%{}, user)
      assert Monitors.get_monitor!(monitor.id) == monitor
    end
  end

  describe "update_monitor/2" do
    test "update_monitor/2 with valid data updates the monitor" do
      user = user_fixture()
      monitor = monitor_fixture(%{}, user)
      assert {:ok, %Monitor{} = monitor} = Monitors.update_monitor(monitor, @update_attrs)
      assert monitor.name == "some updated name"
      assert monitor.reference_id == "some updated reference_id"
      assert monitor.url == "https://diffmonitor.com"
    end

    test "update_monitor/2 with invalid data returns error changeset" do
      user = user_fixture()
      monitor = monitor_fixture(%{}, user)
      assert {:error, %Ecto.Changeset{}} = Monitors.update_monitor(monitor, @invalid_attrs)
      assert monitor == Monitors.get_monitor!(monitor.id)
    end
  end

  describe "delete_monitor/1" do
    test "deletes the monitor" do
      user = user_fixture()
      monitor = monitor_fixture(%{}, user)
      assert {:ok, %Monitor{}} = Monitors.delete_monitor(monitor)
      assert_raise Ecto.NoResultsError, fn -> Monitors.get_monitor!(monitor.id) end
    end
  end

  describe "change_monitor/1" do
    test "returns a monitor changeset" do
      user = user_fixture()
      monitor = monitor_fixture(%{}, user)
      assert %Ecto.Changeset{} = Monitors.change_monitor(monitor)
    end
  end
end
