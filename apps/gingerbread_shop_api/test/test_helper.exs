Application.ensure_all_started(:gingerbread_shop_service)
Application.ensure_all_started(:ecto)

ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(GingerbreadShop.Service.Repo, :manual)
