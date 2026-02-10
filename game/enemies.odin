package game

import "../core"
import "core:slice"
import rl "vendor:raylib"

drawEnemy :: proc(enemy: Enemy) {
	core.drawCircle(enemy.position, enemy.size, enemy.color)
}

drawEnemies :: proc() {
	for enemy in enemies {
		drawEnemy(enemy)
	}
}

enemyMovement :: proc(enemy: ^Enemy) {
	if rl.Vector2Distance(enemy.target.position, enemy.position) < 0.5 {
		return
	}

	dir := enemy.target.position - enemy.position

	if rl.Vector2Length(dir) != 0 {
		dir = rl.Vector2Normalize(dir)
	}

	enemy.position += dir * (enemy.speed * state.dt)
}

enemiesMovement :: proc() {
	for &enemy in enemies {
		enemyMovement(&enemy)
	}
}

generateEnemy :: proc(speed: f32) -> Enemy {
	enemy := Enemy {
		position = core.randomOffScreenVec2(10, 150),
		color    = rl.RED,
		speed    = speed,
		size     = 50.0,
		target   = &player,
	}

	append_elem(&enemies, enemy)
	return enemy
}

killEnemyI :: proc(index: int) {
	unordered_remove(&enemies, index)
}

killEnemyV :: proc(enemy: Enemy) {
	i, f := slice.linear_search(enemies[:], enemy)
	if f {
		killEnemyI(i)
	}
}

generateWave :: proc() {
	enemyCount: i32 = STARTING_ENEMY_COUNT
	enemySpeed: f32 = STARTING_ENEMY_SPEED
	if state.level > 1 {
		enemyCount = cast(i32)(cast(f32)STARTING_ENEMY_COUNT *
				(cast(f32)(state.level - 1) * ENEMY_INCREASE) +
			1)
		enemySpeed =
			STARTING_ENEMY_SPEED * ((cast(f32)(state.level - 1) * ENEMY_SPEED_INCREASE) + 1)
	}

	for i in 0 ..< enemyCount {
		generateEnemy(enemySpeed)
	}
}
