defmodule GingerbreadShop.Service.Repo.Migrations.Store do
    use Ecto.Migration

    def change do
        create table(:stores) do
            add :entity, :uuid,
                null: false

            add :public, :boolean,
                null: false

            add :status, :string,
                null: false

            add :name, :string,
                null: false

            add :phone, :string,
                null: false

            add :address, :map,
                default: "{}",
                null: false

            add :place, :string,
                null: false

            add :geo, :geometry,
                null: false

            add :services, :map,
                default: "{}",
                null: false

            add :assets, :map,
                default: "{}",
                null: false

            timestamps()
        end

        create index(:stores, [:entity], unique: true)
    end
end
