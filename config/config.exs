# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :calendlex,
  owner: %{
    name: "Majd",
    time_zone: "Asia/Hebron",
    day_start: 9,
    day_end: 19
  },
  basic_auth: [username: "admin", password: "admin"],
  ecto_repos: [Calendlex.Repo]

# Configures the endpoint
config :calendlex, CalendlexWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: CalendlexWeb.ErrorHTML, json: CalendlexWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Calendlex.PubSub,
  live_view: [signing_salt: "5oHrmSX2"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
