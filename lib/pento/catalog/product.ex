defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pento.Catalog.Product

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float
    field :image_upload, :string
    timestamps()
    has_many :ratings, Rating
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
    |> validate_number(:unit_price, greater_than: 0.0)
  end

  def markdown_changeset(%Product{unit_price: old_price} = product, attrs) do
    product
    |> cast(attrs, [:unit_price])
    |> validate_required(:unit_price)
    |> validate_number(:unit_price, less_than: old_price)
    end

end
