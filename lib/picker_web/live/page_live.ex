defmodule PickerWeb.PageLive do
  use PickerWeb, :live_view

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, names: [], name: "", selectedName: "")}
  end

  @impl true
  def handle_event("add-name", %{"name" => new_name}, socket) do
    json_names =
      socket.assigns.names
      |> Poison.encode!

    {:ok, _res} = HTTPoison.post "https://textdb.dev/data/054be034-502c-4d18-a9d9-479ea9f60c22",
        json_names,
        [{"Content-Type", "application/json"}]

    Logger.info(new_name)
    Logger.info(inspect socket.assigns.names)
    {:noreply, assign(
        socket,
        names: socket.assigns.names ++ [new_name],
        name: ""
      )}
  end

  def handle_event("select-name", _val, socket) do
    name =
      socket.assigns.names
      |> Enum.random()

    {:noreply, assign(
        socket,
        selectedName: name
      )}
  end

  def handle_event("select-special", _val, socket) do
    {:noreply, assign(
        socket,
        selectedName: "ETHANN"
      )}
  end

end
