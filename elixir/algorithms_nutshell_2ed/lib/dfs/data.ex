# Author José Albert Cruz Almaguer <jalbertcruz@gmail.com>
# Copyright 2016 by José Albert Cruz Almaguer.
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http:www.gnu.org/licenses/agpl-3.0.txt) for more details.

defmodule DFS.MutableHash do

    def start do
        {:ok, p} =  Agent.start fn -> Map.new end
        p
    end

    def get(a, key), do: Agent.get(a, &Map.get(&1, key) )
    def put(a, key, value), do:  Agent.update(a, &Map.put(&1, key, value))
end

defmodule DFS.MutableList do

    def start do
        {:ok, p} =  Agent.start fn -> [] end
        p
    end

    def add(a, value), do: Agent.update(a, &[ value | &1 ]) 
    def get(a), do:  Agent.get(a, fn e -> e end)
end

defmodule DFS.Data do
    defstruct vs: [], es: %{}, pred: DFS.MutableHash.start(), color: DFS.MutableHash.start(), result: DFS.MutableList.start()

    def new nodes, edges do
        %DFS.Data{vs: nodes, es: edges}
    end

end

defimpl DFS.Graph, for: DFS.Data do
    
    def neighbors(g, v), do: g.es[v]

    def dfs(g, s) do
       for v <- g.vs do
            DFS.MutableHash.put(g.pred, v, nil)
            DFS.MutableHash.put(g.color, v, :white)
	   end
       dfsv(g, s)
       
       DFS.MutableList.get(g.result)
       |>:lists.reverse()
    end

    defp dfsv(g, u) do
        DFS.MutableHash.put(g.color, u, :gray)
        for v <- neighbors(g, u) do
            if DFS.MutableHash.get(g.color, v) == :white do
                DFS.MutableHash.put(g.pred, v, u)
                dfsv(g, v)
            end
        end
        DFS.MutableHash.put(g.color, u, :black)

        DFS.MutableList.add(g.result, u)
    end

end
