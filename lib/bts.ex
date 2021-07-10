defmodule BTS do

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
