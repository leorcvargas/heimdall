defmodule Heimdall.Monitors.Monitor do
  use Ecto.Schema
  import Ecto.Changeset
  alias Heimdall.Accounts.User

  schema "monitors" do
    field :name, :string, size: 40
    field :reference_id, :string, size: 64
    field :url, :string, size: 40
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(monitor, attrs) do
    monitor
    |> cast(attrs, [:url, :name, :reference_id])
    |> validate_url()
  end

  def validate_url(changeset) do
    changeset
    |> validate_required([:url])
    |> validate_length(:name, max: 40)
    |> validate_format(:url, ~r/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~?&\/\/=]*)$/)
    |> unsafe_validate_unique(:url, Heimdall.Repo)
    |> unique_constraint(:url)
  end
end
