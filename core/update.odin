package core

import "globals"
import rl "vendor:raylib"

update :: proc(external: proc(), time: ^globals.Time) {
	time.dt = rl.GetFrameTime()
	time.now += time.dt
	if !paused^ {
		updateParticles()
		updateCooldowns()
	}
	external()
}
