defmodule CalendlexWeb.Admin.NewEventTypeLive do
  use CalendlexWeb, :admin_live_view

  alias Calendlex.EventType

  def mount(_, _, socket) do
    event_type = %EventType{}

    socket =
      socket
      |> assign(section: "event_types")
      |> assign(page_title: "New Event Type")
      |> assign(event_type: event_type)
      |> assign(changeset: EventType.changeset(event_type, %{}))

    {:ok, socket}
  end

  def handle_info({:submit, params}, socket) do
    params
    |> Calendlex.insert_event_type()
    |> IO.inspect()
    |> case do
      {:ok, event_type} ->
        socket = put_flash(socket, :info, "Saved")

        {:noreply,
         push_navigate(socket,
           to: ~p"/admin/event_types/#{event_type.id}/edit"
         )}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
