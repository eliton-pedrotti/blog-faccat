defmodule BlogFaccat.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :author, :text
      add :date, :text

      timestamps()
    end

  end
end
