# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :picker,
  ecto_repos: [Picker.Repo]

# Configures the endpoint
config :picker, PickerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dRTQssWnAVHnmC6tswb2LUId+yWKktv3S8rEEDvGcsVzpVN8O/zCbJjLRCfs8TfJ",
  render_errors: [view: PickerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Picker.PubSub,
  live_view: [signing_salt: "5m/4pAge"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
