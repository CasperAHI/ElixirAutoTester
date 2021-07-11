defmodule BTS do

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
