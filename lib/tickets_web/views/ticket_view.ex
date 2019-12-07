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

  def render("validity.json", %{valid: "true"}) do
    %{valid: "true"}
  end

  def render("validity.json", %{valid: "false", reason: reason}) do
    %{valid: "false", reason: reason}
  end

  def render("validity.json", %{valid: "false"}) do
    %{valid: "false"}
  end

  def render("deactivate.json", %{status: "successful", data: ticket}) do
    %{status: "successful", data: ticket |> Map.from_struct() |> Map.drop([:__meta__])}
  end
end
