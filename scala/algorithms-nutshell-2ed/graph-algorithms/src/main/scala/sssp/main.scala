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

package sssp

object main extends App {

  val g = new Graph(
    List(0, 1, 2, 3, 4, 5),
    Map[Int, List[(Int, Double)]](
      0 -> List((1, 6.0), (2, 8.0), (3, 18.0)),
      1 -> List((4, 11.0)),
      2 -> List((3, 9.0)),
      3 -> List(),
      4 -> List((5, 3.0)),
      5 -> List((2, 7.0))
    )
  )

  g.singleSourceShortest(0)

  g.dist.foreach(println(_))

}
