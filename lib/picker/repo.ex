defmodule Picker.Repo do
  use Ecto.Repo,
    otp_app: :picker,
    adapter: Ecto.Adapters.Postgres
end
