defmodule MyAppWeb.LiveEMICalculator do
  use MyAppWeb, :live_view

  @lac 1_00_000

  defmodule State do
    defstruct amount: 0, rate: 0.0, years: 0
  end

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:state, %State{})}
  end

  def render(assigns) do
    ~L"""
      <div class="mx-10">
        <h1 class="font-bold text-xl ">EMI Calculator</h1>
        <form phx-change="change-input">
          <%= live_component(MyAppWeb.LiveComponents.Slider, label: "Principle Amount", name: "amount", value: @state.amount, unit: "Lac(s)", min: 0, max: 200, step: 1) %>
    
          <br/>
          <br/>
    
          <%= live_component(MyAppWeb.LiveComponents.Slider, label: "Rate of Interest", name: "rate", value: @state.rate, unit: "%", min: 0, max: 100, step: 0.5) %>
    
          <br/>
          <br/>
    
          <%= live_component(MyAppWeb.LiveComponents.Slider, label: "Time Period", name: "years", value: @state.years, unit: "Years", min: 0, max: 100, step: 1) %>
        </form>
    
        <br/>
        <br/>
    
        <label class="font-bold">EMI:</label>
        <span><%=calc_emi(@state.amount, @state.rate, @state.years)%></span>
      </div>
    """
  end

  defp calc_emi(principle, rate, years) do
    r = rate / 12 / 100
    n = years * 12
    z = :math.pow(1 + r, n)

    if z == 1 do
      0
    else
      principle * @lac * r * z / (z - 1)
    end
    |> ceil()
  end

  def handle_event(
        "change-input",
        _params = %{"amount" => amount, "rate" => rate, "years" => years},
        socket = %{assigns: %{state: state}}
      ) do
    {:noreply,
     socket
     |> assign(:state, %State{
       state
       | amount: String.to_integer(amount),
         rate: Float.parse(rate) |> elem(0),
         years: String.to_integer(years)
     })}
  end
end
