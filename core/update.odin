package core

import "globals"
import rl "vendor:raylib"

update :: proc(external: proc(), time: ^globals.Time) {
	time.dt = rl.GetFrameTime()
	time.now += time.dt
	if !paused^ {
		for &p, i in globals.particles {
			if p.update != nil {
				p.update(&p)
			} else {
				p.position += p.velocity * time.dt
			}

			p.life -= time.dt
			if p.life <= 0 {
				unordered_remove(&globals.particles, i)
			}
		}
	}
	external()
}
