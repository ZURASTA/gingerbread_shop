defmodule GingerbreadShop.Service.Store.Beacon.Model do
    use Ecto.Schema
    import Ecto
    import Ecto.Changeset
    import Protecto
    @moduledoc """
      A model representing a store's beacon.

      ##Fields

      ###:id
      Is the unique reference to the beacon entry. Is an `integer`.

      ###:store_id
      Is the reference to the store that the beacon belongs to. Is an `integer` to
      `GingerbreadShop.Service.Store.Model`.

      ###:proximity
      The proximity ID of the beacon, or some other identifiable information that the
      beacon broadcasts. Is a `UUID`.

      ###:details
       Are any of the additional identifying data that the beacon will broadcast. Is a `map`.
    """

    schema "beacons" do
        belongs_to :store, GingerbreadShop.Service.Store.Model
        field :proximity, Ecto.UUID
        field :details, :map
        timestamps()
    end

    @doc """
      Builds a changeset for insertion based on the `struct` and `params`.

      Enforces:
      * `store_id` field is required
      * `proximity` field is required
      * `store_id` field is associated with a store in `GingerbreadShop.Service.Store.Model`

    """
    def insert_changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:store_id, :proximity, :details])
        |> validate_required([:store_id, :proximity])
        |> assoc_constraint(:store)
    end

    @doc """
      Builds a changeset for update based on the `struct` and `params`.

      Enforces:
      * `store_id` field is not empty
      * `proximity` field is not empty
      * `store_id` field is associated with a store in `GingerbreadShop.Service.Store.Model`

    """
    def update_changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:store_id, :proximity, :details])
        |> validate_emptiness(:store_id)
        |> validate_emptiness(:proximity)
        |> assoc_constraint(:store)
    end
end
