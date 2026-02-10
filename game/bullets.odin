package game

import "../core"
import "../core/globals"
import "core:math"
import "core:slice"
import rl "vendor:raylib"

drawBullet :: proc(bullet: Bullet) {
	core.drawPolygon(bullet.position, bullet.sides, bullet.size, bullet.rotation, bullet.color)
}

drawBullets :: proc() {
	for bullet in bullets {
		drawBullet(bullet)
	}
}

bulletMovement :: proc(bullet: ^Bullet) {
	bullet.position += bullet.direction * (bullet.speed * state.dt)
	if bullet.position.x < 0 ||
	   bullet.position.x > cast(f32)rl.GetScreenWidth() + 20 ||
	   bullet.position.y < 0 ||
	   bullet.position.y > cast(f32)rl.GetScreenHeight() + 20 {
		i, f := slice.linear_search(bullets[:], bullet^)
		removeBulletV(bullet^)
	}

	if bullet.friendly {
		for enemy in enemies {
			if rl.CheckCollisionCircleRec(
				enemy.position,
				enemy.size,
				core.getPolyHitbox(bullet.position, bullet.size),
			) {
				killEnemyV(enemy)
				removeBulletV(bullet^)
			}
		}
	} else {
		if rl.CheckCollisionRecs(
			core.createRectangleV(player.position, player.size),
			core.getPolyHitbox(bullet.position, bullet.size),
		) {
			// Kill the player and remove bullet
			// This allows for enemies with guns :)
		}
	}
}

bulletsMovement :: proc() {
	for &bullet in bullets {
		bulletMovement(&bullet)
	}
}

generateBullet :: proc(parent: globals.Entity, target: globals.Entity, friendly: bool) {
	dir := target.position - parent.position
	dir = rl.Vector2Normalize(dir)

	rotation := math.atan2(dir.y, dir.x) * (180.0 / rl.PI)
	bullet := Bullet {
		position  = parent.position,
		color     = rl.BLACK,
		speed     = 300.0,
		size      = 10.0,
		sides     = 3,
		rotation  = rotation,
		direction = dir,
		friendly  = friendly,
	}
	append_elem(&bullets, bullet)
}

removeBulletI :: proc(index: int) {
	unordered_remove(&bullets, index)
}

removeBulletV :: proc(bullet: Bullet) {
	i, f := slice.linear_search(bullets[:], bullet)
	if f {
		killEnemyI(i)
	}
}
