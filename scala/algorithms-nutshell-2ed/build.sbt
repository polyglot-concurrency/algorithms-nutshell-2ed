name := "algorithms-nutshell-2ed"

version := "0.0.1"

scalaVersion := "2.11.8"


def CommonSettings(name: String): Project = (
  Project(name, file(name))
    settings(

    )
  )

lazy val common = (
  CommonSettings("common")
    settings(

    )
  )

lazy val graphAlgorithms = (
  CommonSettings("graph-algorithms")
    dependsOn common
    settings(

    )
  )
