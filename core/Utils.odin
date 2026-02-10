package core

import "core:math/rand"
import rl "vendor:raylib"
import "globals"

createRectangleV :: proc(pos, size: rl.Vector2) -> rl.Rectangle {
  return rl.Rectangle{pos.x, pos.y, size.x, size.y}
}

anchorToVec2 :: proc(a: globals.Anchor) -> rl.Vector2 {
  return globals.Anchor_Vectors[a]
}

centerOfScreen :: proc() -> rl.Vector2 {
  return rl.Vector2{cast(f32)rl.GetScreenWidth()/2, cast(f32)rl.GetScreenHeight()/2}
}

randomOffScreenVec2 :: proc(padding, margin: f32) -> rl.Vector2 {
  width := cast(f32)rl.GetScreenWidth()
  height := cast(f32)rl.GetScreenHeight()

  side := rand.int_range(0, 3)
  offset := padding + rand.float32_range(0, margin)

  x := rand.float32_range(0, width)
  y := rand.float32_range(0, height)

  switch side {
    case 0:
      y = - margin
    case 1:
      y = height + offset
    case 2:
      x = -margin
    case 3:
      x = width + offset
  }

  return rl.Vector2{x, y}
}