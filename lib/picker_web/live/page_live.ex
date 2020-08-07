defmodule PickerWeb.PageLive do
  use PickerWeb, :live_view

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} =
      HTTPoison.get(
        "https://textdb.dev/api/data/054be034-502c-4d18-a9d9-479ea9f60c22",
        [{"accepts", "application/json"}],
        []
      )

    {:ok,
     assign(socket,
       names: body |> Poison.decode!() |> Map.get("_json"),
       name: "",
       selectedName: ""
     )}
  end

  @impl true
  def handle_event("add-name", %{"name" => new_name}, socket) do
    new_name_list = socket.assigns.names ++ [new_name]

    json_names =
      new_name_list
      |> Poison.encode!()

    Task.start(fn ->
      HTTPoison.post(
        "https://textdb.dev/api/data/054be034-502c-4d18-a9d9-479ea9f60c22",
        json_names,
        [{"Content-Type", "application/json"}]
      )
    end)

    {:noreply,
     assign(
       socket,
       names: new_name_list,
       name: ""
     )}
  end

  def handle_event("select-name", _val, socket) do
    name =
      socket.assigns.names
      |> Enum.random()

    {:noreply,
     assign(
       socket,
       selectedName: name
     )}
  end

  def handle_event("select-special", _val, socket) do
    {:noreply,
     assign(
       socket,
       selectedName: "ETHANN"
     )}
  end
end
