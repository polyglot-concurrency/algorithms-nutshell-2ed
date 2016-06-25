# Author José Albert Cruz Almaguer <jalbertcruz@gmail.com>
# Copyright 2016 by José Albert Cruz Almaguer.
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http:www.gnu.org/licenses/agpl-3.0.txt) for more details.


defmodule Collection.PriorityQueue do

    def start do
        {:ok, p} =  Agent.start fn -> [] end
        p
    end

    def stop(a), do: Agent.stop(a)

    def add(a, value), do: Agent.update(a, &[ value | &1 ])

    def get_min(a) do
        {{result, _}, pos} = Agent.get(a,
                                       fn e ->
                                           t = Enum.with_index(e)
                                           Enum.min_by(t, fn {{_, p}, _}-> p end)                
                                       end)

        Agent.update(a, fn e -> List.delete_at(e, pos) end)

        result
    end

    def decrease_priority(a, value, delta) do

        pos = Agent.get(a,
                fn e ->
                    Enum.find_index(e, fn {k, _} -> k == value end)
                end)

        Agent.update(a,
                    fn e ->
                        List.update_at(e, pos,
                        fn {k, v} ->
                            if v == :infinity do
                                {k, delta}
                            else
                                {k, v - delta}
                            end
                        end)
                    end)
    end

    def empty?(a), do: Agent.get(a, &Enum.empty?(&1))

end
