package core

import rl "vendor:raylib"
import "globals"

draw :: proc(external : proc()) {
  rl.BeginDrawing()
  defer rl.EndDrawing()

  rl.ClearBackground(rl.BLUE)
  external()
}

drawRectPro :: proc(pos, size: rl.Vector2, color: rl.Color, rotation: f32, origin: globals.Anchor) {
  rl.DrawRectanglePro(createRectangleV(pos, size), anchorToVec2(origin), rotation, color)
}