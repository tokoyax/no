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
    {_, _, _, debug} = args
    message = buffer(args)
    case debug do
      true -> IO.inspect({:debug, message, self()})
      _    -> IO.puts(message)
    end
    say(args)
  end

  defp buffer(args) do
    {argv, process_num, _, debug} = args

    message = case debug do
      true -> "#{expletive(argv)} from process no.#{process_num}"
      _    -> expletive(argv)
    end

    buffer(args, message, [])
  end

  defp buffer(args, message, list) do
    # faster than append last
    # https://hexdocs.pm/elixir/List.html
    list = [message | list]
    cond do
      IO.iodata_length(list) >= 4096 -> list
      true -> buffer(args, message, list)
    end
  end

  defp expletive(_ = ''), do: "n\n"
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
      _   -> String.to_integer(opts[:processes])
    end

    Enum.each((1..num), fn(n) ->
      spawn_link(No, :say, [{argv, n, self(), opts[:debug]}]) end)
  end

  defp wait(args) do
    wait(args)
  end
end
