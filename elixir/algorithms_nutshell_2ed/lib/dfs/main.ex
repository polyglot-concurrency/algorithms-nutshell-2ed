# Author José Albert Cruz Almaguer <jalbertcruz@gmail.com>
# Copyright 2016 by José Albert Cruz Almaguer.
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http:www.gnu.org/licenses/agpl-3.0.txt) for more details.


defmodule Dfs.Main do
    alias Dfs.Data, as: D

    def run do
	    D.new( [111 | Enum.to_list(0..14)], 
                %{ 
                    2 => [1, 11, 10],
                    1 => [2, 3, 0],
                    3 => [1, 4, 12],
                    4 => [3, 5, 13],
                    5 => [4, 6, 9],
                    6 => [0, 5, 7],
                    7 => [6, 8, 9],
                    8 => [0, 7, 14],
                    9 => [5, 7, 111],
                    10 => [2],
                    11 => [2],
                    12 => [3],
                    13 => [4],
                    14 => [8],
                    0 => [1, 6, 8],
                    111 => [9]
                } 
            )
        |> Dfs.Graph.dfs(0) 
    end

end
