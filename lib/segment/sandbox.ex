defmodule Segment.Sandbox do
  @moduledoc """
  Provides an api that can be used in tests to ensure
  data is correctly sent to segment.io.
  """
  alias Segment.{Track, Identify, Screen, Alias, Group, Page, Context}
  use Agent

  @init_struct %{
    track_calls: [],
    identify_calls: [],
    screen_calls: [],
    alias_calls: [],
    group_calls: [],
    page_calls: []
  }

  def start_link(_args) do
    Agent.start_link(fn -> @init_struct end, name: __MODULE__)
  end

  @doc """
  Checkout function provides means to reset sandbox state to blank initial state.
  """
  def checkout() do
    Agent.update(__MODULE__, fn _state -> @init_struct end)
  end

  def track(t = %Track{}) do
    Agent.update(__MODULE__, fn state -> %{state | track_calls: [t | state.track_calls]} end)
  end

  def get_track_calls do
    Agent.get(__MODULE__, &Map.get(&1, :track_calls))
  end

  def track(user_id, event, properties \\ %{}, context \\ Context.new()) do
    t = %Track{userId: user_id, event: event, properties: properties, context: context}
    track(t)
  end

  def identify(i = %Identify{}) do
    Agent.update(__MODULE__, fn state -> %{state | identify_calls: [i | state.identify_calls]} end)
  end

  def get_identify_calls do
    Agent.get(__MODULE__, &Map.get(&1, :identify_calls))
  end

  def identify(user_id, traits \\ %{}, context \\ Context.new()) do
    i = %Identify{userId: user_id, traits: traits, context: context}
    identify(i)
  end

  def screen(s = %Screen{}) do
    Agent.update(__MODULE__, fn state -> %{state | screen_calls: [s | state.screen_calls]} end)
  end

  def get_screen_calls do
    Agent.get(__MODULE__, &Map.get(&1, :screen_calls))
  end

  def screen(user_id, name \\ "", properties \\ %{}, context \\ Context.new()) do
    s = %Screen{userId: user_id, name: name, properties: properties, context: context}
    screen(s)
  end

  def alias_user(a = %Alias{}) do
    Agent.update(__MODULE__, fn state -> %{state | alias_calls: [a | state.alias_calls]} end)
  end

  def get_alias_calls do
    Agent.get(__MODULE__, &Map.get(&1, :alias_calls))
  end

  def alias_user(user_id, previous_id, context \\ Context.new()) do
    a = %Alias{userId: user_id, previousId: previous_id, context: context}
    alias_user(a)
  end

  def group(g = %Group{}) do
    Agent.update(__MODULE__, fn state -> %{state | group_calls: [g | state.group_calls]} end)
  end

  def get_group_calls do
    Agent.get(__MODULE__, &Map.get(&1, :group_calls))
  end

  def group(user_id, group_id, traits \\ %{}, context \\ Context.new()) do
    g = %Group{userId: user_id, groupId: group_id, traits: traits, context: context}
    group(g)
  end

  def page(p = %Page{}) do
    Agent.update(__MODULE__, fn state -> %{state | page_calls: [p | state.page_calls]} end)
  end

  def get_page_calls do
    Agent.get(__MODULE__, &Map.get(&1, :page_calls))
  end

  def page(user_id, name \\ "", properties \\ %{}, context \\ Context.new()) do
    p = %Page{userId: user_id, name: name, properties: properties, context: context}
    page(p)
  end

end
