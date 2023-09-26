defmodule GameOfLifeWeb.Live.LongPoll do
  use Phoenix.LiveView

  def render(assigns) do
    ~L{<div> LongPoll LiveView </div>}
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
