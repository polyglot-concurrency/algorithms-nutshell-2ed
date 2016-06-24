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

import scala.collection.mutable

import graphs.Color

case class Node(info: Int)


class Graph(nodes: List[Int], edges: Map[Int, List[Int]]) {

  val V = nodes.map(Node(_))

  val E = mutable.HashMap[Node, List[Node]]()

  val pred = mutable.HashMap[Node, Node]()
  val color = mutable.HashMap[Node, Color.Value]()

  edges.foreach(e =>
    E(Node(e._1)) = e._2.map(new Node(_)))

  def neighbors(v: Node) = E(v)

  def dfs(s: Int): Unit = {
    dfs(Node(s))
  }

  def dfs(s: Node): Unit = {
    for (v <- V) {
      pred(v) = null
      color(v) = Color.White
    }
    dfsv(s)
  }


  def dfsv(u: Node): Unit = {

    color(u) = Color.Gray

    for (v <- neighbors(u))
      if (color(v) == Color.White) {
        pred(v) = u
        dfsv(v)
      }

    color(u) = Color.Black

    result += u
  }


  val result = mutable.ArrayBuffer[Node]()

}
