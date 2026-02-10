package main

import rl "vendor:raylib"
import "core"
import "core/globals"
import "game"

main :: proc() {
  core.startWindow("Video Game")
  defer core.killWindow()

  for !rl.WindowShouldClose() {
    core.update(game.update, &game.state.time)
    core.draw(game.draw)
  }
}