defmodule Segment do
  @moduledoc """
  Provides the API for sending data to Segment.
  """

  use Application
  alias Segment.Context

  @api Application.get_env(:segment, :api) || Segment.Server

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      {@api, []}
    ]

    opts = [strategy: :one_for_one, name: Segment.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defdelegate track(user_id, event, properties \\ %{}, context \\ Context.new()), to: @api
  defdelegate track(t), to: @api

  defdelegate identify(user_id, traits, context \\ Context.new()), to: @api
  defdelegate identify(i), to: @api

  defdelegate screen(user_id, name, properties \\ %{}, context \\ Context.new()), to: @api
  defdelegate screen(s), to: @api

  defdelegate alias_user(previous_id, user_id, context \\ Context.new()), to: @api
  defdelegate alias_user(a), to: @api

  defdelegate group(user_id, group_id, traits \\ %{}, context \\ Context.new()), to: @api
  defdelegate group(g), to: @api

  defdelegate page(user_id, name, properties \\ %{}, context \\ Context.new()), to: @api
  defdelegate page(p), to: @api
end
