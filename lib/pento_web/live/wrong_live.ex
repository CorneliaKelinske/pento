defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}
  alias PentoWeb.Router.Helpers, as: Routes

  def mount(_params, session, socket) do
    {:ok,
     assign(socket,
       score: 10,
       message: "Make a guess:",
       lucky_number: lucky_number(),
       time: time(),
       game_won?: false,
       session_id: session["live_socket_id"]
     )}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
    <%= @message %>
    </h2>
    It's <%= @time %>
    <h2>
    <%= for n <- 1..10 do %>
    <a href="#" phx-click="guess" phx-value-number= {n} ><%= n %></a>
    <% end %>
    </h2>
    <%= if @game_won? == true do %>
    <btn> <%= live_redirect "Play again!", to: Routes.live_path(@socket, PentoWeb.WrongLive) %> </btn>

    <% end %>
    <pre>
    <%= @current_user.email %>
    <%= @session_id %>
    </pre>

    """
  end

  def handle_event(
        "guess",
        %{"number" => guess} = data,
        %{assigns: %{lucky_number: lucky_number}} = socket
      ) do
    case guess do
      ^lucky_number ->
        message = "You win"

        {
          :noreply,
          assign(
            socket,
            message: message,
            time: time(),
            game_won?: true
          )
        }

      _ ->
        message = "Your guess: #{guess}. Wrong. Guess again. "
        score = socket.assigns.score - 1

        {
          :noreply,
          assign(
            socket,
            message: message,
            score: score,
            time: time()
          )
        }
    end
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def lucky_number() do
    Enum.random(1..10) |> to_string
  end

  def time() do
    DateTime.utc_now() |> to_string
  end
end
