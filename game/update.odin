package game

import "../core"

fireCooldown: f32 = 0.0

update :: proc() {
	handlePause()

	if !state.paused {
		playerMovement()
		enemiesMovement()
		handleDebug()
		bulletsMovement()
		if len(enemies) <= 0 {
			startGen = true
		} else {
			count = 0
			startGen = false
		}
	}
}
