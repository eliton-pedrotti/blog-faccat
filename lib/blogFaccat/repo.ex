defmodule BlogFaccat.Repo do
  use Ecto.Repo,
    otp_app: :blogFaccat,
    adapter: Ecto.Adapters.Postgres
end
