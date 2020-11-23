defmodule BlogFaccatWeb.PostController do
  use BlogFaccatWeb, :controller

  alias BlogFaccat.MyBlogFaccat
  alias BlogFaccat.MyBlogFaccat.Post

  def index(conn, _params) do
    posts = MyBlogFaccat.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = MyBlogFaccat.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case MyBlogFaccat.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post criado com sucesso!")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = MyBlogFaccat.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = MyBlogFaccat.get_post!(id)
    changeset = MyBlogFaccat.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = MyBlogFaccat.get_post!(id)

    case MyBlogFaccat.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post atualizado com sucesso!")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = MyBlogFaccat.get_post!(id)
    {:ok, _post} = MyBlogFaccat.delete_post(post)

    conn
    |> put_flash(:info, "Post deletado com sucesso!")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
