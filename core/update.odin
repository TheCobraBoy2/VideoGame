package core

import rl "vendor:raylib"
import "globals"

update :: proc(external: proc(), time : ^globals.Time) {
  time.dt = rl.GetFrameTime()
  time.now += time.dt
  external()
}