defmodule Pento.Repo.Migrations.AddNotNullConstraintToUsername do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :username, :string, null: false, from: :string
    end
  end
end
