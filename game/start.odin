package game

import rl "vendor:raylib"
import "../core/globals"

initializeGame :: proc() {
  player = Player{
    position = rl.Vector2{globals.WINDOW_WIDTH/2, globals.WINDOW_HEIGHT/2},
    size = rl.Vector2{80, 80},
    color = rl.GREEN,
    origin = globals.Anchor.Center,
    rotation = 0.0,
    speed = 250.0
  }
}