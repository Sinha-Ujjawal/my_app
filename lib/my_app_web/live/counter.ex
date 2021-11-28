defmodule MyAppWeb.LiveCounter do
  use MyAppWeb, :live_view

  @initial_count 0

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:count, @initial_count)}
  end

  def render(assigns) do
    ~L"""
      <div>
        <div><button phx-click="up">+</button></div>
        <div><text>Count: <%= @count %></text></div>
        <div><button phx-click="down">-</button></div>
      </div>
    """
  end

  def handle_event("up", _unsigned_params, socket = %{assigns: %{count: count}}) do
    {:noreply, socket |> assign(:count, count + 1)}
  end

  def handle_event("down", _unsigned_params, socket = %{assigns: %{count: count}}) do
    {:noreply, socket |> assign(:count, count - 1)}
  end
end
