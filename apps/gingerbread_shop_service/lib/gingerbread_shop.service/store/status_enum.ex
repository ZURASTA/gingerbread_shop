import EctoEnum

if Application.get_env(:gingerbread_shop_service, GingerbreadShop.Service.Repo, adapter: Ecto.Adapters.Postgres)[:adapter] == Ecto.Adapters.Postgres do
    quote do: defenum GingerbreadShop.Service.Store.StatusEnum, :store_status, [:closed, :open, :busy]
else
    quote do: defenum GingerbreadShop.Service.Store.StatusEnum, [closed: 0, open: 1, busy: 2]
end
|> Code.eval_quoted([], __ENV__)
