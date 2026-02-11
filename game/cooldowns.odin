package game

import "../core"
import rl "vendor:raylib"

waveStartCooldown: f32 = 5.0
oneSecond: f32 = 1.0

createCooldowns :: proc() {
	core.createCooldown(&player.attackSpeed, proc() {
		generateBullet(player, core.closestEntity(player, stripEnemiesToEntities())^, true)
	}, proc() -> bool {
		return len(enemies) > 0
	})

	core.createCooldown(&oneSecond, proc() {
		count += 1
	}, proc() -> bool {
		return startGen
	})

	core.createCooldown(&waveStartCooldown, proc() {
		state.level += 1
		generateWave()
	}, proc() -> bool {
		return startGen
	})
}
