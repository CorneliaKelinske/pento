defmodule Pento.Catalog.Search do
  import Ecto.Changeset

  defstruct [:sku]
  @types %{sku: :string}

  def changeset(%__MODULE__{} = search, attrs) do
    {search, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required(:sku)
    |> validate_format(:sku, ~r/\d+/)
    |> validate_length(:sku, is: 7)
  end
end
