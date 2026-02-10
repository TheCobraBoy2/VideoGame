package core

import rl "vendor:raylib"
import "globals"

createRectangleV :: proc(pos, size: rl.Vector2) -> rl.Rectangle {
  return rl.Rectangle{pos.x, pos.y, size.x, size.y}
}

anchorToVec2 :: proc(a: globals.Anchor) -> rl.Vector2 {
  return globals.Anchor_Vectors[a]
}