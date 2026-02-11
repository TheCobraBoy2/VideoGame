package core

import "globals"
import rl "vendor:raylib"

createCooldown :: proc(duration: ^f32, callback: proc(), limitation: proc() -> bool) {
	cooldown := globals.Cooldown {
		time       = 0.0,
		duration   = duration,
		callback   = callback,
		limitation = limitation,
	}
	append_elem(&globals.cooldowns, cooldown)
}

updateCooldowns :: proc() {
	for &cooldown in globals.cooldowns {
		if cooldown.limitation() {
			cooldown.time += rl.GetFrameTime()
			if cooldown.time >= cooldown.duration^ {
				cooldown.callback()
				cooldown.time = 0.0
			}
		}
	}
}
