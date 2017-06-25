defmodule GingerbreadShop.Service.Store.Model do
    use Ecto.Schema
    import Ecto
    import Ecto.Changeset
    import Protecto
    @moduledoc """
      A model representing a store.

      ##Fields

      ###:id
      Is the unique reference to the store entry. Is an `integer`.

      ###:entity
      Is the entity the store belongs to. Is an `UUID`.

      ###:public
      Whether the store is publicly listed or private. Is a `boolean`.

      ###:status
      Is the current operating status of the store. Is a `GingerbreadShop.Service.Store.StatusEnum`.

      ###:name
      Is the name of the store. Is a `string`.

      ###:phone
      Is the phone number of the store. Is a `string`.

      ###:address
      Is the address of the store. Is a `map`.

      ###:place
      Is the place/building complex the store is located at. Is a `string`.

      ###:geo
      Is the longitude/latitude of where the store is located. Is a `geometry`.          null: false

      ###:services
      Are the services the store offers. Is a `map`.

      ###:assets
      Are the image assets that have been associated with the store. Is a `map`.
    """

    schema "stores" do
        field :entity, Ecto.UUID
        field :public, :boolean
        field :status, GingerbreadShop.Service.Store.StatusEnum
        field :name, :string
        field :phone, :string
        field :address, :map
        field :place, :string
        field :geo, Geo.Point
        field :services, :map
        field :assets, :map
        timestamps()
    end

    @doc """
      Builds a changeset for insertion based on the `struct` and `params`.

      Enforces:
      * `entity` field is required
      * `public` field is required
      * `status` field is required
      * `name` field is required
      * `phone` field is required
      * `address` field is required
      * `geo` field is required
      * `services` field is required
      * `assets` field is required
      * checks uniqueness of the entity
    """
    def insert_changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:entity, :public, :status, :name, :phone, :address, :place, :geo, :services, :assets])
        |> validate_required([:entity, :public, :status, :name, :phone, :address, :geo, :services, :assets])
        |> validate_phone_number(:phone)
        |> unique_constraint(:entity)
    end

    @doc """
      Builds a changeset for update based on the `struct` and `params`.

      Enforces:
      * `entity` field is not empty
      * `public` field is not empty
      * `status` field is not empty
      * `name` field is not empty
      * `phone` field is not empty
      * `address` field is not empty
      * `geo` field is not empty
      * `services` field is not empty
      * `assets` field is not empty
      * checks uniqueness of the entity
    """
    def update_changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:entity, :public, :status, :name, :phone, :address, :place, :geo, :services, :assets])
        |> validate_emptiness(:entity)
        |> validate_emptiness(:public)
        |> validate_emptiness(:status)
        |> validate_emptiness(:name)
        |> validate_emptiness(:phone)
        |> validate_emptiness(:address)
        |> validate_emptiness(:geo)
        |> validate_emptiness(:services)
        |> validate_emptiness(:assets)
        |> validate_phone_number(:phone)
        |> unique_constraint(:entity)
    end
end
