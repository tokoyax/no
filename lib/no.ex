defmodule No do
  @moduledoc """
  Documentation for No.
  """

  def main(args) do
    args
    |> parse_args()
    |> run()
  end

  def say(args) do
    {argv, process_num} = args
    IO.puts "#{argv} at #{process_num}"
  end

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
      processes: :integer
    ]
  end

  defp aliases_list() do
    [
      p: :processes
    ]
  end

  def run(args) do
    {argv, opts} = args
    num = String.to_integer(opts[:processes])
    say({argv, num})
  end
end
