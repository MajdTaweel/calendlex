defmodule CalendlexWeb.Admin.Components.EventTypeForm do
  use CalendlexWeb, :live_component

  alias Calendlex.EventType
  alias Ecto.Changeset

  def update(
        %{
          event_type: %EventType{color: current_color, slug: slug} = event_type,
          changeset: changeset
        },
        socket
      ) do
    socket =
      socket
      |> assign(changeset: changeset)
      |> assign(event_type: event_type)
      |> assign(current_color: current_color)
      |> assign(public_url: build_public_url(slug))

    {:ok, socket}
  end

  def handle_event(
        "change",
        %{"event_type" => params},
        %{assigns: %{event_type: event_type}} = socket
      ) do
    changeset = EventType.changeset(event_type, params)
    public_url = build_public_url(get_slug(changeset))

    {:noreply, assign(socket, changeset: changeset, public_url: public_url)}
  end

  def handle_event("set_color", %{"color" => color}, %{assigns: %{changeset: changeset}} = socket) do
    changeset = Ecto.Changeset.put_change(changeset, :color, color)

    {:noreply, assign(socket, changeset: changeset, current_color: color)}
  end

  def handle_event("submit", %{"event_type" => params}, socket) do
    send(self(), {:submit, params})

    {:noreply, socket}
  end

  defp build_public_url(nil) do
    build_public_url("")
  end

  defp build_public_url(slug) do
    url(~p"/#{slug}")
  end

  defp get_slug(%Changeset{changes: %{slug: slug}}), do: slug
  defp get_slug(%Changeset{data: %{slug: slug}}), do: slug
end
