defmodule Exqueue.Queue do
  use GenServer

  @default_state [1, 2, 3]

  # Client

  def start_link(init_state \\ @default_state) when is_list(init_state),
    do: GenServer.start_link(__MODULE__, init_state)

  def enqueue(pid, element), do: GenServer.cast(pid, {:enqueue, element})

  def dequeue(pid), do: GenServer.call(pid, :dequeue)

  # Server

  @impl true
  def init(state) do
    {:ok, state}
  end

  # Sync
  @impl true
  def handle_cast({:enqueue, element}, state), do:
    {:noreply, state ++ [element]}


  @impl true
  def handle_call(:dequeue, _from, [head | tail]), do: {:reply, head, tail}

  @impl true
  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

end
