defmodule BlogFaccat.MyBlogFaccat.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :author, :string
    field :body, :string
    field :date, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :author, :date])
    |> validate_required([:title, :body, :author, :date])
  end
end
