defmodule Heimdall.Repo.Migrations.CreateMonitors do
  use Ecto.Migration

  def change do
    create table(:monitors) do
      add :url, :string, size: 40
      add :name, :string, size: 40, null: true
      add :reference_id, :string, size: 64, null: true
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:monitors, [:user_id])
    create unique_index(:monitors, [:url])
  end
end
