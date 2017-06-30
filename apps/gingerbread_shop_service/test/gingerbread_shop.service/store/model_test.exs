defmodule GingerbreadShop.Service.Store.ModelTest do
    use GingerbreadShop.Service.Case

    alias GingerbreadShop.Service.Store

    @valid_model %Store.Model{
        entity: Ecto.UUID.generate(),
        public: true,
        status: :open,
        name: "Foo Bar",
        phone: "+0123",
        address: %{ "street" => "123 test st", "city" => "foo" },
        place: "Foobar Plaza",
        geo: %Geo.Point{ coordinates: { 0.0, 0.0 }, srid: 4326 },
        services: %{},
        assets: %{}
    }

    test "empty" do
        refute_change(%Store.Model{}, %{}, :insert_changeset)

        assert_change(@valid_model, %{}, :update_changeset)
    end

    test "only entity" do
        refute_change(%Store.Model{}, %{ entity: @valid_model.entity }, :insert_changeset)

        assert_change(@valid_model, %{ entity: Ecto.UUID.generate() }, :update_changeset)
    end

    test "only public" do
        refute_change(%Store.Model{}, %{ public: @valid_model.public }, :insert_changeset)

        assert_change(@valid_model, %{ public: false }, :update_changeset)
    end

    test "only status" do
        refute_change(%Store.Model{}, %{ status: @valid_model.status }, :insert_changeset)

        assert_change(@valid_model, %{ status: :open }, :update_changeset)
    end

    test "only name" do
        refute_change(%Store.Model{}, %{ name: @valid_model.name }, :insert_changeset)

        assert_change(@valid_model, %{ name: "foo" }, :update_changeset)
    end

    test "only phone" do
        refute_change(%Store.Model{}, %{ phone: @valid_model.phone }, :insert_changeset)

        assert_change(@valid_model, %{ phone: "+1234"}, :update_changeset)
    end

    test "only geo" do
        refute_change(%Store.Model{}, %{ geo: @valid_model.geo }, :insert_changeset)

        assert_change(@valid_model, %{ geo: %Geo.Point{ coordinates: { 0.0, 1.0 }, srid: 4326 } }, :update_changeset)
    end

    test "only address" do
        refute_change(%Store.Model{}, %{ address: @valid_model.address }, :insert_changeset)

        assert_change(@valid_model, %{ address: %{ "street" => "123 foo st", "city" => "bar" } }, :update_changeset)
    end

    test "only place" do
        refute_change(%Store.Model{}, %{ place: @valid_model.place }, :insert_changeset)

        assert_change(@valid_model, %{ place: "Test Food Court" }, :update_changeset)
    end

    test "only services" do
        refute_change(%Store.Model{}, %{ services: @valid_model.services }, :insert_changeset)

        assert_change(@valid_model, %{ services: %{ "test" => "foo" } }, :update_changeset)
    end

    test "only assets" do
        refute_change(%Store.Model{}, %{ assets: @valid_model.assets }, :insert_changeset)

        assert_change(@valid_model, %{ assets: %{ "test" => "foo" } }, :update_changeset)
    end

    test "without public" do
        refute_change(@valid_model, %{ public: nil }, :insert_changeset)

        refute_change(@valid_model, %{ public: nil }, :update_changeset)
    end

    test "without status" do
        refute_change(@valid_model, %{ status: nil }, :insert_changeset)

        refute_change(@valid_model, %{ status: nil }, :update_changeset)
    end

    test "without name" do
        refute_change(@valid_model, %{ name: nil }, :insert_changeset)

        refute_change(@valid_model, %{ name: nil }, :update_changeset)
    end

    test "without phone" do
        refute_change(@valid_model, %{ phone: nil }, :insert_changeset)

        refute_change(@valid_model, %{ phone: nil }, :update_changeset)
    end

    test "without geo" do
        refute_change(@valid_model, %{ geo: nil }, :insert_changeset)

        refute_change(@valid_model, %{ geo: nil }, :update_changeset)
    end

    test "without address" do
        refute_change(@valid_model, %{ address: nil }, :insert_changeset)

        refute_change(@valid_model, %{ address: nil }, :update_changeset)
    end

    test "without place" do
        assert_change(@valid_model, %{ place: nil }, :insert_changeset)

        assert_change(@valid_model, %{ place: nil }, :update_changeset)
    end

    test "without services" do
        assert_change(@valid_model, %{ services: nil }, :insert_changeset)

        assert_change(@valid_model, %{ services: nil }, :update_changeset)
    end

    test "without assets" do
        assert_change(@valid_model, %{ assets: nil }, :insert_changeset)

        assert_change(@valid_model, %{ assets: nil }, :update_changeset)
    end

    test "phone formatting" do
        refute_change(@valid_model, %{ phone: "123" }, :insert_changeset)
        |> assert_error_value(:phone, { "should begin with a country prefix", [validation: :phone_number] })

        refute_change(@valid_model, %{ phone: "+123a" }, :insert_changeset)
        |> assert_error_value(:phone, { "should contain the country prefix followed by only digits", [validation: :phone_number] })

        refute_change(@valid_model, %{ phone: "+" }, :insert_changeset)
        |> assert_error_value(:phone, { "should contain between 1 and 18 digits", [validation: :phone_number] })

        refute_change(@valid_model, %{ phone: "+1234567890123456789" }, :insert_changeset)
        |> assert_error_value(:phone, { "should contain between 1 and 18 digits", [validation: :phone_number] })

        refute_change(@valid_model, %{ phone: "123" }, :update_changeset)
        |> assert_error_value(:phone, { "should begin with a country prefix", [validation: :phone_number] })

        refute_change(@valid_model, %{ phone: "+123a" }, :update_changeset)
        |> assert_error_value(:phone, { "should contain the country prefix followed by only digits", [validation: :phone_number] })

        refute_change(@valid_model, %{ phone: "+" }, :update_changeset)
        |> assert_error_value(:phone, { "should contain between 1 and 18 digits", [validation: :phone_number] })

        refute_change(@valid_model, %{ phone: "+1234567890123456789" }, :update_changeset)
        |> assert_error_value(:phone, { "should contain between 1 and 18 digits", [validation: :phone_number] })
    end

    test "uniqueness" do
        entity = Ecto.UUID.generate()
        entity2 = Regex.replace(~r/[\da-f]/, entity, fn
            "0", _ -> "1"
            "1", _ -> "2"
            "2", _ -> "3"
            "3", _ -> "4"
            "4", _ -> "5"
            "5", _ -> "6"
            "6", _ -> "7"
            "7", _ -> "8"
            "8", _ -> "9"
            "9", _ -> "a"
            "a", _ -> "b"
            "b", _ -> "c"
            "c", _ -> "d"
            "d", _ -> "e"
            "e", _ -> "f"
            "f", _ -> "0"
        end)
        store = GingerbreadShop.Service.Repo.insert!(Store.Model.insert_changeset(@valid_model, %{ entity: entity }))

        assert_change(@valid_model, %{ entity: entity }, :insert_changeset)
        |> assert_insert(:error)
        |> assert_error_value(:entity, { "has already been taken", [] })

        assert_change(@valid_model, %{ entity: entity2 }, :insert_changeset)
        |> assert_insert(:ok)
    end
end
