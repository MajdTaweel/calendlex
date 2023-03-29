defmodule CalendlexWeb.Live.InitAssigns do
  import Phoenix.Component

  def on_mount(:default, _params, _session, socket) do
    owner = Application.get_env(:calendlex, :owner)
    socket = assign(socket, :owner, owner)

    {:cont, socket}
  end
end
