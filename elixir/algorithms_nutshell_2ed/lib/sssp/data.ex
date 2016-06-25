# Author José Albert Cruz Almaguer <jalbertcruz@gmail.com>
# Copyright 2016 by José Albert Cruz Almaguer.
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http:www.gnu.org/licenses/agpl-3.0.txt) for more details.


defmodule SSSP.Data do
    defstruct vs: [], es: %{},
              pred: Collection.MutableHash.start(),
              dist: Collection.MutableHash.start()

    def new nodes, edges do
        %SSSP.Data{vs: nodes, es: edges}
    end

end

defimpl SSSP.Graph, for: SSSP.Data do

    def neighbors(g, v), do: Enum.map(g.es[v], fn {k, _} -> k end)

    def weight(g, u, v) do
        {_, res} = List.keyfind(g.es[u], v, 0)
        res
    end

    def single_source_shortest(g, s) do
        pq = Collection.PriorityQueue.start()
        for v <- g.vs do
             Collection.MutableHash.put(g.dist, v, :infinity)
             Collection.MutableHash.put(g.pred, v, nil)
        end

        Collection.MutableHash.put(g.dist, s, 0)

        for v <- g.vs, do: Collection.PriorityQueue.add(pq, {v, Collection.MutableHash.get(g.dist, v)})

        loop(g, pq)

        Collection.PriorityQueue.stop(pq)
        g.dist
    end

    defp plus(a, b) do
        if a == :infinity or b == :infinity do
            :infinity
        else
            a + b
        end
    end

    defp loop(g, pq) do
        if not Collection.PriorityQueue.empty?(pq) do
            u = Collection.PriorityQueue.get_min pq
            n = neighbors(g, u)
            for v <- n,
                w = weight(g, u, v),
                newLen = plus(Collection.MutableHash.get(g.dist, u), w),
                newLen < Collection.MutableHash.get(g.dist, v) do

                Collection.PriorityQueue.decrease_priority(pq, v, newLen)

                Collection.MutableHash.put(g.dist, v, newLen)
                Collection.MutableHash.put(g.pred, v, u)

            end

            loop(g, pq)
        end

    end

end
