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

generateEnemy :: proc() -> Enemy {
	enemy := Enemy {
		position = core.randomOffScreenVec2(10, 150),
		color    = rl.RED,
		speed    = 80.0,
		size     = 50.0,
		target   = &player,
	}

	append_elem(&enemies, enemy)
	return enemy
}

killEnemyI :: proc(index: int) {
	free(enemies[index].target)
	unordered_remove(&enemies, index)
}

killEnemyV :: proc(enemy: Enemy) {
	i, f := slice.linear_search(enemies[:], enemy)
	if f {
		killEnemyI(i)
	}
}
