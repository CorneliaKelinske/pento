defmodule PentoWeb.SearchLive do
  @moduledoc """
  This LiveView was part of an exercise for practising using a schemaless changeset to validate user input
  """
  use PentoWeb, :live_view

  alias Pento.{Catalog, Catalog.Search}

  def mount(_params, _session, socket) do
    {:ok,
    socket
    |> assign_search()
    |> assign_changeset()}
  end

  def assign_search(socket) do
    socket
    |> assign(:search, %Search{})
  end

  def assign_changeset(%{assigns: %{search: search}} = socket) do
    socket
    |> assign(:changeset, Catalog.change_search(search))
  end

  def handle_event(
    "validate",
    %{"search" => search_params},
    %{assigns: %{search: search}} = socket) do

      changeset =
        search
        |> Catalog.change_search(search_params)
        |> Map.put(:action, :validate)

       {:noreply,
      socket
      |> assign(:changeset, changeset)}
    end

    def handle_event("save", %{"search" => search_params}, socket) do
      :timer.sleep(1000)
      #...
    end
end
