defmodule Pento.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias Pento.Repo

  alias Pento.Catalog.Product


  def list_products do
    Repo.all(Product)
  end


  def get_product!(id), do: Repo.get!(Product, id)


  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end


  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end


  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end


  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  def markdown_product(%Product{} = product, new_unit_price) do
   product
   |> Product.markdown_changeset(%{unit_price: new_unit_price})
   |> Repo.update()
  end

  def list_products_with_user_rating(user) do
    Product.Query.with_user_ratings(user)
    |> Repo.all()
  end
end
