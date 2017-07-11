defmodule GingerbreadShop.Service.Repo.Migrations.Beacon do
    use Ecto.Migration

    def change do
        create table(:beacons) do
            add :store_id, references(:stores),
                null: false

            add :proximity, :uuid,
                null: false

            add :details, :map,
                default: "{}",
                null: false

            timestamps()
        end

        create index(:beacons, [:proximity], unique: false)
    end
end
