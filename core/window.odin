package core

import rl "vendor:raylib"

import "globals"

startWindow :: proc(title: cstring) {
  rl.SetTargetFPS(globals.TARGET_FPS)
  rl.InitWindow(globals.WINDOW_WIDTH, globals.WINDOW_HEIGHT, title)
}

killWindow :: proc() {
  rl.CloseWindow()
}