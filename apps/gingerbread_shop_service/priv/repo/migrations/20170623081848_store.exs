defmodule GingerbreadShop.Service.Repo.Migrations.Store do
    use Ecto.Migration

    def change do
        store_status = if Application.get_env(:gingerbread_shop_service, GingerbreadShop.Service.Repo, adapter: Ecto.Adapters.Postgres)[:adapter] == Ecto.Adapters.Postgres do
            GingerbreadShop.Service.Store.StatusEnum.create_type()
            :store_status
        else
            :integer
        end

        create table(:stores) do
            add :entity, :uuid,
                null: false

            add :public, :boolean,
                null: false

            add :status, store_status,
                null: false

            add :name, :string,
                null: false

            add :phone, :string,
                null: false

            add :address, :map,
                default: "{}",
                null: false

            add :place, :string

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
