package core

import "core:fmt"
import rl "vendor:raylib"
import "globals"

drawDebug : ^globals.DrawDebug

draw :: proc(external : proc()) {
  rl.BeginDrawing()
  defer rl.EndDrawing()

  rl.ClearBackground(rl.BLUE)
  external()
}

drawRectPro :: proc(pos, size: rl.Vector2, color: rl.Color, rotation: f32, origin: globals.Anchor) {
  anchor := anchorToVec2(origin)
  rl.DrawRectanglePro(
    createRectangleV(pos, size),
    size * anchor,
    rotation,
    color
  )
  if drawDebug^ {
    rl.DrawRectangleLinesEx(createRectangleV(pos - size * anchor, size), 2, rl.RED)
    rl.DrawCircleV(pos, 2, rl.RED)
  }
}