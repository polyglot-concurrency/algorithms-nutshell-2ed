# Author José Albert Cruz Almaguer <jalbertcruz@gmail.com>
# Copyright 2016 by José Albert Cruz Almaguer.
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http:www.gnu.org/licenses/agpl-3.0.txt) for more details.


defmodule SSSP.Main do
    alias SSSP.Data, as: D

    def run do
	    g = D.new( Enum.to_list(0..5), 
               %{ 
                   0 => [{1, 6.0}, {2, 8.0}, {3, 18.0}],
                   1 => [{4, 11.0}],
                   2 => [{3, 9.0}],
                   3 => [],
                   4 => [{5, 3.0}],
                   5 => [{2, 7.0}]
               } 
            )

        SSSP.Graph.single_source_shortest(g, 0)

        Collection.MutableHash.get(g.dist)
    end

end
