defmodule GingerbreadShop.Service.Repo.Migrations.StoreBeacon do
    use Ecto.Migration

    def change do
        create table(:store_beacons) do
            add :proximity, :uuid,
                null: false

            add :details, :map,
                default: "{}",
                null: false

            timestamps()
        end

        create index(:store_beacons, [:proximity], unique: false)
    end
end
