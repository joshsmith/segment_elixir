defmodule Segment.Analytics do
  alias Segment.Context
  alias Segment.Http

  require Logger

  def track(t = %Segment.Track{}) do
    call(t)
  end

  def track(user_id, event, properties \\ %{}, context \\ Context.new()) do
    %Segment.Track{userId: user_id, event: event, properties: properties, context: context}
    |> call
  end

  def identify(i = %Segment.Identify{}) do
    call(i)
  end

  def identify(user_id, traits \\ %{}, context \\ Context.new()) do
    %Segment.Identify{userId: user_id, traits: traits, context: context}
    |> call
  end

  def screen(s = %Segment.Screen{}) do
    call(s)
  end

  def screen(user_id, name \\ "", properties \\ %{}, context \\ Context.new()) do
    %Segment.Screen{userId: user_id, name: name, properties: properties, context: context}
    |> call
  end

  def alias_user(a = %Segment.Alias{}) do
    call(a)
  end

  def alias_user(previous_id, user_id, context \\ Context.new()) do
    %Segment.Alias{userId: user_id, previousId: previous_id, context: context}
    |> call
  end

  def group(g = %Segment.Group{}) do
    call(g)
  end

  def group(user_id, group_id, traits \\ %{}, context \\ Context.new()) do
    %Segment.Group{userId: user_id, groupId: group_id, traits: traits, context: context}
    |> call
  end

  def page(p = %Segment.Page{}) do
    call(p)
  end

  def page(user_id, name \\ "", properties \\ %{}, context \\ Context.new()) do
    %Segment.Page{userId: user_id, name: name, properties: properties, context: context}
    |> call
  end

  defp call(api) do
    Task.async(fn -> post_to_segment(api.method, Jason.encode!(api)) end)
  end

  defp post_to_segment(function, body) do
    Http.post(function, body)
    |> log_result(function, body)
  end

  defp log_result({_, %{status_code: code}}, function, body) when code in 200..299 do
    # success
    Logger.debug("Segment #{function} call success: #{code} with body: #{body}")
  end

  defp log_result({_, %{status_code: code}}, function, body) do
    # HTTP failure
    Logger.debug("Segment #{function} call failed: #{code} with body: #{body}")
  end

  defp log_result(error, function, body) do
    # every other failure
    Logger.debug("Segment #{function} call failed: #{inspect(error)} with body: #{body}")
  end
end
