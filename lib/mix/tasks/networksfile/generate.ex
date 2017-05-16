defmodule Mix.Tasks.NetworksFile.Generate do
  use Mix.Task

  @usage """
  Usage:

    mix networks_file.generate --file networks.def --size 1000 --length 2

  Arguments:

    --file, -f      Specifies the file to write the networks to
    --size, -s      Specifies the number of networks to create
    --length, -l    Specifies the length of each node of the network
  """

  @moduledoc """
  Utility task to create long and randomized network files

  #{@usage}
  """

  @unknownusage """
  Invalid command arguments

  #{@usage}
  """

  def run(args) do
    OptionParser.parse(args,
        strict: [file: :string, size: :integer, length: :integer, help: :boolean],
        aliases: [f: :file, s: :size, l: :length])
        |> validate_options
        |> execute
  end

  defp random_definition(length) do
    r = fn -> ?a..?z |> Enum.shuffle |> Enum.take(length) |> List.to_string end
    (Network.make(r.()) |> Network.include(r.()) |> Network.list |> Enum.join(" ")) <> "\n"
  end

  defp execute({:ok, file, size, length}) do
    file = File.stream!(file, [:write])
    Stream.repeatedly(fn -> random_definition(length) end) |> Stream.take(size)  |> Stream.into(file) |> Stream.run
  end

  defp execute({:error, message}) do
    IO.puts message
  end

  defp validate_options({[file: file, size: size, length: length], _, _}) do
    {:ok, file, size, length}
  end

  defp validate_options({[size: size, length: length], [file | _], _}) do
    {:ok, file, size, length}
  end

  defp validate_options({[help: true], [], []}) do
    {:error, @usage}
  end

  defp validate_options({[], [], []}) do
    {:error, @usage}
  end

  defp validate_options(_) do
    {:error, @unknownusage}
  end
end