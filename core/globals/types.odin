// Contains some base types that can be used for games

package globals

import rl "vendor:raylib"

Time :: struct {
  now : f32,
  dt : f32
}

Entity :: struct {
  position : rl.Vector2,
  size : rl.Vector2,
  color : rl.Color,
  origin : Anchor,
  rotation : f32,
  speed : f32
}

Anchor :: enum {
  TopLeft,
  Top,
  TopRight,

  Left,
  Center,
  Right,

  BottomLeft,
  Bottom,
  BottomRight,
}

Anchor_Vectors := [Anchor]rl.Vector2{
  .TopLeft = {0.0, 0.0},
  .Top = {0.5, 0.0},
  .TopRight = {1.0, 0.0},

  .Left = {0.0, 0.5},
  .Center = {0.5, 0.5},
  .Right = {1.0, 0.5},

  .BottomLeft = {0.0, 1.0},
  .Bottom = {0.5, 1.0},
  .BottomRight = {1.0, 1.0},
}