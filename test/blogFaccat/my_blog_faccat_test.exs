defmodule BlogFaccat.MyBlogFaccatTest do
  use BlogFaccat.DataCase

  alias BlogFaccat.MyBlogFaccat

  describe "posts" do
    alias BlogFaccat.MyBlogFaccat.Post

    @valid_attrs %{author: "some author", body: "some body", date: "some date", title: "some title"}
    @update_attrs %{author: "some updated author", body: "some updated body", date: "some updated date", title: "some updated title"}
    @invalid_attrs %{author: nil, body: nil, date: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MyBlogFaccat.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert MyBlogFaccat.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert MyBlogFaccat.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = MyBlogFaccat.create_post(@valid_attrs)
      assert post.author == "some author"
      assert post.body == "some body"
      assert post.date == "some date"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MyBlogFaccat.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = MyBlogFaccat.update_post(post, @update_attrs)
      assert post.author == "some updated author"
      assert post.body == "some updated body"
      assert post.date == "some updated date"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = MyBlogFaccat.update_post(post, @invalid_attrs)
      assert post == MyBlogFaccat.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = MyBlogFaccat.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> MyBlogFaccat.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = MyBlogFaccat.change_post(post)
    end
  end
end
