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
    rl.DrawRectangleLinesEx(createRectangleV(pos - size * anchor, size), 3, rl.RED)
    rl.DrawCircleV(pos, 3, rl.RED)
  }
}

drawCircle :: proc(pos: rl.Vector2, size: f32, color: rl.Color) {
  rl.DrawCircleV(pos, size, color)
  if drawDebug^ {
    rl.DrawCircleV(pos, 3, rl.WHITE)
    rl.DrawCircleLinesV(pos, size, rl.WHITE)
    rl.DrawCircleLinesV(pos, size + 1, rl.WHITE)
    rl.DrawCircleLinesV(pos, size + 2, rl.WHITE)
  }
}