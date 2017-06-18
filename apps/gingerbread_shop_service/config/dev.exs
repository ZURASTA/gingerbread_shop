use Mix.Config

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Configure database
config :gingerbread_shop_service, GingerbreadShop.Service.Repo,
    adapter: Ecto.Adapters.Postgres,
    username: "postgres",
    password: "postgres",
    database: "gingerbread_shop_service_dev",
    hostname: "localhost",
    pool_size: 10
