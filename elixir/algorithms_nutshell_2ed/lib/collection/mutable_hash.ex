# Author José Albert Cruz Almaguer <jalbertcruz@gmail.com>
# Copyright 2016 by José Albert Cruz Almaguer.
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http:www.gnu.org/licenses/agpl-3.0.txt) for more details.

defmodule Collection.MutableHash do

    def start do
        {:ok, p} =  Agent.start fn -> Map.new end
        p
    end

    def get(a, key), do: Agent.get(a, &Map.get(&1, key) )

    def put(a, key, value), do:
         Agent.update(a, &Map.put(&1, key, value))
    
    def stop(a), do: Agent.stop(a)

    def get(a), do: Agent.get(a, fn e -> e end )
end
