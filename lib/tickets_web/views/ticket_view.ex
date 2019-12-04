defmodule TicketsWeb.TicketView do
  use TicketsWeb, :view

  def render("create.json", %{success: true}) do
    %{result: "success"}
  end

  def render("create.json", %{success: false}) do
    %{result: "failure"}
  end

  def render("all_promocodes.json", %{all_promocodes: all_promocodes}) do
    all_promocodes
  end

  def render("active_promocodes.json", %{active_promocodes: active_promocodes}) do
    active_promocodes
  end
end
