defmodule BTS do

  require Logger


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

  def toString({value, left, right}) do
    if left == nil do
      if right == nil do
        "{ 'Value': " <> Integer.to_string(value) <> ", 'Left :' nil, 'Right:' nil }"
      else
        "{ 'Value': " <> Integer.to_string(value) <> ", 'Left :' nil, 'Right:' " <> toString(right) <> " }"
      end
    else
      if right == nil do
        "{ 'Value': " <> Integer.to_string(value) <> ", 'Left :' " <> toString(left) <> ", 'Right:' nil }"
      else
        "{ 'Value': " <> Integer.to_string(value) <> ", 'Left :' " <> toString(left) <> ", 'Right:' " <> toString(right) <> " }"
      end
    end
  end

  def new() do
    {nil, nil, nil}
  end
  def new(a) do
    BTS.insert(a, {nil, nil, nil})
  end

  
  def insert( [], tree )  do
    tree
  end
  def insert([input|tail], tree) do
    newTree = BTS.insert(input, tree)
    BTS.insert(tail, newTree)
  end
  def insert(input, {value, left, right}) do
    if (value == nil or value == input) do
      {input, left, right}
    else
      if input > value do
        if right == nil do
          {value, left, {input, nil, nil}}
        else
          {value, left, BTS.insert(input, right)}
        end
      else
        if left == nil do
          {value, {input, nil, nil}, right}
        else
          {value, BTS.insert(input, left), right}
        end
      end
    end
  end
end
