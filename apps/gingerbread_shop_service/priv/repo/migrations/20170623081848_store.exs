defmodule GingerbreadShop.Service.Repo.Migrations.Store do
    use Ecto.Migration

    def change do
        create table(:stores) do
            add :public, :boolean,
                null: false

            add :status, :string,
                null: false

            add :name, :string,
                null: false

            add :phone, :string,
                null: false

            add :address, :map,
                null: false

            add :place, :string,
                null: false

            add :geo, :geometry,
                null: false

            add :services, :map,
                null: false

            add :assets, :map,
                null: false

            timestamps()
        end
    end
end
