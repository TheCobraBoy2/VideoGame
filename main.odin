package main

import rl "vendor:raylib"
import "core"
import "core/globals"

main :: proc() {
  core.startWindow("Video Game")
  defer core.killWindow()

  for !rl.WindowShouldClose() {
    core.update()
    core.draw()
  }
}