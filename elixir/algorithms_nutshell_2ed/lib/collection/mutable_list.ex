# Author José Albert Cruz Almaguer <jalbertcruz@gmail.com>
# Copyright 2016 by José Albert Cruz Almaguer.
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http:www.gnu.org/licenses/agpl-3.0.txt) for more details.

defmodule Collection.MutableList do

    def start do
        {:ok, p} =  Agent.start fn -> [] end
        p
    end

    def add(a, value), do: Agent.update(a, &[ value | &1 ]) 
    def get(a), do: Agent.get(a, fn e -> e end)

    def stop(a), do: Agent.stop(a)
end
