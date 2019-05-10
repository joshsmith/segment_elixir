defmodule Segment do
  @moduledoc """
  Provides the API for sending data to Segment.
  """

  use Application

  @api Application.get_env(:segment, :api) || Segment.Server

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      {@api, []}
    ]

    opts = [strategy: :one_for_one, name: Segment.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defdelegate track(t), to: @api
  defdelegate identify(i), to: @api
  defdelegate screen(s), to: @api
  defdelegate alias_user(a), to: @api
  defdelegate group(g), to: @api
  defdelegate page(p), to: @api
end
