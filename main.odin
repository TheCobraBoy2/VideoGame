package main

import rl "vendor:raylib"
import "core"
import "game"

main :: proc() {
  core.startWindow("Video Game")
  defer core.killWindow()

  game.initializeGame()

  core.drawDebug = &game.state.drawDebug

  for !rl.WindowShouldClose() {
    core.update(game.update, &game.state.time)
    core.draw(game.draw)
  }
}