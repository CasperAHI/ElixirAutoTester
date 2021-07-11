defmodule RESTAPI do
  require Logger
  Code.require_file("bts.ex")


  def accept(port) do
    {:ok, socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])
    Logger.info("Accepting connections on port #{port}")
    loop_acceptor(socket, {nil, nil, nil})
  end

  defp loop_acceptor(socket, tree) do
    {:ok, client} = :gen_tcp.accept(socket)
    serve(client, tree)
    loop_acceptor(socket, tree)
  end

  defp serve(socket, tree) do
    line = read_line(socket)
    newtree = write_line(line, socket, tree)

    serve(socket, newtree)
  end

  defp read_line(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    data
  end

  defp write_line(line, socket, tree) do

    newLine = IO.inspect line
    IO.puts newLine

    list = String.split(newLine, ",")
    list = Enum.map(list, fn x -> elem(Integer.parse(String.trim(x)), 0)  end)

    newtree = BTS.insert(list, tree)

    text = BTS.toString(newtree)
    IO.puts text

    response = """
      HTTP/1.1 200 OK\r
      #{text}
      """
    :gen_tcp.send(socket, response)
    newtree
  end
end