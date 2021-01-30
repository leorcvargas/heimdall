defmodule Heimdall.Monitors.Monitor do
  use Ecto.Schema
  import Ecto.Changeset
  alias Heimdall.Accounts.User

  schema "monitors" do
    field :name, :string, size: 40
    field :reference_id, :string, size: 128
    field :url, :string, size: 160
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(monitor, attrs) do
    monitor
    |> cast(attrs, [:url, :name, :reference_id])
    |> validate_url()
    |> validate_name()
    |> validate_reference_id()
  end

  def validate_reference_id(changeset) do
    changeset
    |> validate_length(:name, max: 128)
  end

  def validate_name(changeset) do
    changeset
    |> validate_length(:name, max: 40)
  end

  def validate_url(changeset) do
    changeset
    |> validate_required([:url])
    |> validate_length(:url, max: 160)
    |> validate_format(:url, ~r/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~?&\/\/=]*)$/)
    |> unsafe_validate_unique(:url, Heimdall.Repo)
    |> unique_constraint(:url)
  end
end
