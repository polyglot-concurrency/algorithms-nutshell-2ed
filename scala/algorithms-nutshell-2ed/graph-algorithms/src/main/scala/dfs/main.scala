/**
  * Author José Albert Cruz Almaguer <jalbertcruz@gmail.com>
  * Copyright 2016 by José Albert Cruz Almaguer.
  *
  * This program is licensed to you under the terms of version 3 of the
  * GNU Affero General Public License. This program is distributed WITHOUT
  * ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
  * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
  * AGPL (http:www.gnu.org/licenses/agpl-3.0.txt) for more details.
  */

package dfs

object main extends App {

  val g = new Graph(
    List(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 0, 111),
    Map[Int, List[Int]](
      2 -> List(1, 11, 10),
      1 -> List(2, 3, 0),
      3 -> List(1, 4, 12),
      4 -> List(3, 5, 13),
      5 -> List(4, 6, 9),
      6 -> List(0, 5, 7),
      7 -> List(6, 8, 9),
      8 -> List(0, 7, 14),
      9 -> List(5, 7, 111),
      10 -> List(2),
      11 -> List(2),
      12 -> List(3),
      13 -> List(4),
      14 -> List(8),
      0 -> List(1, 6, 8),
      111 -> List(9)
    )
  )

  g.dfs(0)

  println(g.result.mkString(" "))

}
