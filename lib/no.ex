defmodule No do
  @moduledoc """
  Documentation for No.
  """

  def main(args) do
    args
    |> parse_args()
    |> run()
    |> wait()
  end

  def say(args) do
    {argv, process_num, sender, debug} = args
    case debug do
      true -> send sender, {:debug, "#{expletive(argv)} from process no.#{process_num}", self()}
      _    -> send sender, {:ok, expletive(argv)}
    end
    say(args)
  end

  defp expletive(_ = ''), do: 'n'
  defp expletive(value), do: value

  defp parse_args(args) do
    {opts, argv, _} = OptionParser.parse(
      args,
      swithces: options_list(),
      aliases: aliases_list()
    )
    {argv, opts}
  end

  defp options_list() do
    [
      processes: :integer,
      debug: :boolean,
    ]
  end

  defp aliases_list() do
    [
      p: :processes,
      d: :debug,
    ]
  end

  defp run(args) do
    {argv, opts} = args
    num = case opts[:processes] do
      nil -> 1
      _  -> String.to_integer(opts[:processes])
    end
    (1..num)
    |> Enum.each(
      fn(n) ->
        spawn_link(No, :say, [{argv, n, self(), opts[:debug]}])
      end
    )
  end

  defp wait(args) do
    receive do
      {:ok, message} ->
        IO.puts message
      {:debug, message, pid} ->
        IO.inspect {message, pid}
    end
    wait(args)
  end
end
