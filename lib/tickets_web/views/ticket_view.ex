defmodule TicketsWeb.TicketView do
  use TicketsWeb, :view

  def render("create.json", %{success: true}) do
    %{result: "success"}
  end

  def render("create.json", %{success: false}) do
    %{result: "failure"}
  end
end
