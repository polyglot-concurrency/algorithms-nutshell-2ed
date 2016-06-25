# Author José Albert Cruz Almaguer <jalbertcruz@gmail.com>
# Copyright 2016 by José Albert Cruz Almaguer.
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http:www.gnu.org/licenses/agpl-3.0.txt) for more details.

defmodule DFS.Data do
    defstruct vs: [], es: %{}, pred: Collection.MutableHash.start(), color: Collection.MutableHash.start(), result: Collection.MutableList.start()

    def new nodes, edges do
        %DFS.Data{vs: nodes, es: edges}
    end

end

defimpl DFS.Graph, for: DFS.Data do
    
    def neighbors(g, v), do: g.es[v]

    def dfs(g, s) do
       for v <- g.vs do
            Collection.MutableHash.put(g.pred, v, nil)
            Collection.MutableHash.put(g.color, v, :white)
	   end
       dfsv(g, s)
       
       Collection.MutableList.get(g.result)
       |> Enum.reverse
    end

    defp dfsv(g, u) do
        Collection.MutableHash.put(g.color, u, :gray)
        for v <- neighbors(g, u) do
            if Collection.MutableHash.get(g.color, v) == :white do
                Collection.MutableHash.put(g.pred, v, u)
                dfsv(g, v)
            end
        end
        Collection.MutableHash.put(g.color, u, :black)

        Collection.MutableList.add(g.result, u)
    end

end
