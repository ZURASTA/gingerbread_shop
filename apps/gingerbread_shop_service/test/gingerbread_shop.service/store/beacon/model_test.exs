defmodule GingerbreadShop.Service.Beacon.ModelTest do
    use GingerbreadShop.Service.Case

    alias GingerbreadShop.Service.Store.Beacon

    @valid_model %Beacon.Model{
        store_id: 1,
        proximity: Ecto.UUID.generate(),
        details: %{ "major" => "1", "minor" => "1" }
    }

    test "empty" do
        refute_change(%Beacon.Model{}, %{}, :insert_changeset)

        assert_change(@valid_model, %{}, :update_changeset)
    end

    test "only store" do
        refute_change(%Beacon.Model{}, %{ store_id: @valid_model.store_id }, :insert_changeset)

        assert_change(@valid_model, %{ store_id: 0 }, :update_changeset)
    end

    test "only proximity" do
        refute_change(%Beacon.Model{}, %{ proximity: @valid_model.proximity }, :insert_changeset)

        assert_change(@valid_model, %{ proximity: Ecto.UUID.generate() }, :update_changeset)
    end

    test "only details" do
        refute_change(%Beacon.Model{}, %{ details: @valid_model.details }, :insert_changeset)

        assert_change(@valid_model, %{ details: %{ "major" => "2", "minor" => "5" } }, :update_changeset)
    end

    test "without store" do
        refute_change(@valid_model, %{ store_id: nil }, :insert_changeset)

        refute_change(@valid_model, %{ store_id: nil }, :update_changeset)
    end

    test "without proximity" do
        refute_change(@valid_model, %{ proximity: nil }, :insert_changeset)

        refute_change(@valid_model, %{ proximity: nil }, :update_changeset)
    end

    test "without details" do
        assert_change(@valid_model, %{ details: nil }, :insert_changeset)

        assert_change(@valid_model, %{ details: nil }, :update_changeset)
    end
end
