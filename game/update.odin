package game

import "../core"

fireCooldown: f32 = 0.0

update :: proc() {
	handlePause()

	if !state.paused {
		if len(enemies) > 0 {
			if fireCooldown >= player.attackSpeed {
				fireCooldown = 0.0
				generateBullet(player, core.closestEntity(player, stripEnemiesToEntities())^, true)
			} else {
				fireCooldown += state.dt
			}
		}

		playerMovement()
		enemiesMovement()
		handleDebug()
		bulletsMovement()
	} else {
	}
}
