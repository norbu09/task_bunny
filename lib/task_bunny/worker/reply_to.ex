defmodule TaskBunny.Worker.ReplyTo do
  use TaskBunny.Job
  require Logger

  def perform(message) do
    case message["meta"]["app_id"] do
      "undefined" ->
        Logger.info("response: #{inspect message}")
      pid_string ->
        pid = pid_string
        |> String.to_charlist
        |> :erlang.list_to_pid
        send(pid, message)
    end
    :ok
  end
end
