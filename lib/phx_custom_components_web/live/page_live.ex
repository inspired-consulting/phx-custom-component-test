defmodule PhxCustomComponentsWeb.PageLive do
  use PhxCustomComponentsWeb, :live_view

  @clock_interval 500

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    if connected?(socket), do: schedule_update_time()

    socket
    |> update_time()
    |> ok()
  end

  @impl Phoenix.LiveView
  def handle_info(:update_time, socket) do
    schedule_update_time()

    socket
    |> update_time()
    |> noreply()
  end

  defp schedule_update_time(), do: Process.send_after(self(), :update_time, @clock_interval)

  defp update_time(socket) do
    assign(socket, time: DateTime.utc_now() |> DateTime.truncate(:second))
  end

  defp noreply(socket), do: {:noreply, socket}
  defp ok(socket), do: {:ok, socket}
end
