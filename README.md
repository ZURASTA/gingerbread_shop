# gingerbread_shop

[![Stories in Ready](https://badge.waffle.io/ZURASTA/gingerbread_shop.png?label=ready&title=Ready)](https://waffle.io/ZURASTA/gingerbread_shop?utm_source=badge)
[![CircleCI](https://circleci.com/gh/ZURASTA/gingerbread_shop.svg?style=svg)](https://circleci.com/gh/ZURASTA/gingerbread_shop)

Store management service


## Configuration

The service may be configured with the following options:

### Setup Mode

The service has two setup modes: `:auto` and `:manual`. When the service is started in `:auto`, it will automatically handle creating and migrating the database. When the service is started in `:manual`, the state of the database is left up to the user to manually setup.

By default the service runs in `:auto` mode. To change this behaviour, pass in the `{ :setup_mode, mode }` when starting the application.

### Database

The database options can be configured by providing the config for the key `GingerbreadShop.Service.Repo`.

For details on how to configure an [Ecto repo](https://hexdocs.pm/ecto/Ecto.Repo.html).

__Note:__ If a PostgreSQL database is used, the service will create a custom type. For details on how to interact with this type, see the [EctoEnum docs](http://hexdocs.pm/ecto_enum).

__Note:__ Relies on PostgreSQL for geo-spatial support (PostGIS extension).
