defmodule MyAppWeb.LiveComponents.Slider do
  use MyAppWeb, :live_component

  def render(assigns) do
    ~H"""
      <label class="font-bold w-max"><%= @label %></label>
      <input type="range" class="appearance-none w-full my-10 h-1 bg-gray-200 rounded outline-none slider-thumb" name={@name} value={@value} min={@min} max={@max} step={@step}>
      <%= @value %> <%= @unit %>
    """
  end
end
