defmodule Mix.Tasks.NetworksFile.Feed do
  use Mix.Task

  @usage """
  Usage:

    mix networks_file.feed --file networks.def

  Arguments:

    --file, -f      Specifies the file where to read the networks from
  """

  @moduledoc """
  Utility task to stream and feed really long network files into the REST API

  #{@usage}
  """

  @unknownusage """
  Invalid command arguments

  #{@usage}
  """

  def run(args) do
    OptionParser.parse(args, strict: [file: :string], aliases: [f: :file]) |> validate_options |> execute
  end

  defp feed_node(definition) do
    request = fn ->
      body = Poison.Encoder.encode(%{"nodes" => String.split(definition)}, [])
      HTTPoison.post(endpoint(), body, [{"Content-type", "application/json"}])
    end
    {time, response} = request |> :timer.tc
    timetaken = time |> Kernel./(1_000)
    case response do
        {_, %HTTPoison.Error{reason: reason}} -> IO.puts "Error feeding the Rest API (#{reason})"
        {_, %HTTPoison.Response{status_code: _, body: _}} -> IO.puts "Fed nodes [#{String.trim(definition)}] in #{timetaken}ms"
    end
  end

  defp endpoint() do
    cfg = Application.get_env(:network_collisions, NetworkCollisions.Endpoint)
    host = cfg[:url][:host]
    port = cfg[:http][:port]
    cond do
        port == 443 -> "https://#{host}:443"
        true -> "http://#{host}:#{port}"
    end <> "/api/networks"
  end

  defp test_connection() do
    case HTTPoison.get(endpoint(), [{"Accept", "application/json"}]) do
        {result, %HTTPoison.Error{reason: reason}} -> {result, reason}
        {result, %HTTPoison.Response{status_code: http_code, body: body}} -> {result, http_code, body}
    end
  end

  defp process_file(file) do
    file = File.stream!(file, [:read])
    Stream.each(file, &feed_node/1) |> Stream.run
    IO.puts "Finished. Visit #{endpoint()} to check out the created networks."
  end

  defp execute({:ok, file}) do
    HTTPoison.start
    case test_connection() do
        {:ok, _, _} -> process_file(file)
        {:error, reason} -> IO.puts "Connection test failed [#{reason}]. Did you start the Rest API server?"
    end
  end

  defp execute({:error, message}) do
    IO.puts message
  end

  defp validate_options({[file: file], _, _}) do
    {:ok, file}
  end

  defp validate_options({[], [file | _], _}) do
    {:ok, file}
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