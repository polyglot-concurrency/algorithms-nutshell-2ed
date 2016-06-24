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

import scala.collection.mutable

case class Node(info: Int)


class Graph(nodes: List[Int], edges: Map[Int, List[(Int, Double)]]) {

  def getMin(pq: mutable.ListBuffer[(Node, Double)]) = {
    val ((r, _), pos) = pq.zipWithIndex.minBy[Double](e => e._1._2)
    pq.remove(pos)
    r
  }

  def decreasePriority(pq: mutable.ListBuffer[(Node, Double)], n: Node, np: Double): Unit = {
    val pos = pq.map(_._1).indexOf(n)
    val (_, priority) = pq(pos)
    pq.remove(pos)

    pq += Tuple2(n,
      if (priority == Double.PositiveInfinity)
        np
      else
        priority - np
    )

  }

  val V = nodes.map(Node(_))

  val E = mutable.HashMap[Node, List[(Node, Double)]]()

  edges.foreach(e =>
    E(Node(e._1)) = e._2.map(e =>
      (Node(e._1), e._2)
    )
  )

  def neighbors(v: Node) = E(v).map(_._1)


  def singleSourceShortest(s: Int): Unit =
    singleSourceShortest(Node(s))

  val pred = mutable.HashMap[Node, Node]()
  val dist = mutable.HashMap[Node, Double]()

  def weight(u: Node, v: Node) = E(u).find(e => e._1 == v).get._2

  // Dijkstra’s Algorithm
  def singleSourceShortest(s: Node): Unit = {
    val pq = mutable.ListBuffer[(Node, Double)]()
    for (v <- V) {
      dist(v) = Double.PositiveInfinity
      pred(v) = null
    }

    dist(s) = 0
    for (v <- V)
      pq += Tuple2(v, dist(v))

    while (!pq.isEmpty) {

      val u = getMin(pq)

      for (v <- neighbors(u);
           w = weight(u, v);
           newLen = dist(u) + w;
           if (newLen < dist(v))) {

        decreasePriority(pq, v, newLen)

        dist(v) = newLen
        pred(v) = u

      }

    }
  }
}
