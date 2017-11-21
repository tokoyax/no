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
    message = buffer(args)
    IO.puts(message)
    say(args)
  end

  defp buffer(args) do
    {argv, process_num, _, debug} = args

    message = case debug do
      true -> {:debug, "#{expletive(argv)} from process no.#{process_num}", self()}
      _    -> expletive(argv)
    end

    {:ok, pid} = StringIO.open("")
    buffer(pid, args, message)
  end

  defp buffer(str_io, args, message) do
    IO.puts(str_io, message)
    {_, output} = StringIO.contents(str_io)

    cond do
      IO.iodata_length(output) > 10240 -> StringIO.flush(str_io)
      true -> buffer(str_io, args, message)
    end
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

    Enum.each((1..num), fn(n) ->
      spawn_link(No, :say, [{argv, n, self(), opts[:debug]}]) end)
  end

  defp wait(args) do
    wait(args)
  end
end
