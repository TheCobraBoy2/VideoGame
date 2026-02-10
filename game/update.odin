package game

import "../core"

fireCooldown: f32 = 0.0

update :: proc() {
	bulletsMovement()
	playerMovement()
	enemiesMovement()
	handleDebug()

	if fireCooldown >= 2.0 {
		fireCooldown = 0.0
		generateBullet(player, core.closestEntity(player, stripEnemiesToEntities())^, true)
	} else {
		fireCooldown += state.dt
	}
}
