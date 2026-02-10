package game

import "../core"
import "../core/globals"
import rl "vendor:raylib"

drawBullet :: proc(bullet: Bullet) {
	core.drawPolygon(bullet.position, bullet.sides, bullet.size, -90.0, bullet.color)
}

drawBullets :: proc() {
	for bullet in bullets {
		drawBullet(bullet)
	}
}

generateBullet :: proc(parent: globals.Entity) {
	bullet := Bullet {
		position = parent.position,
		color    = rl.BLACK,
		speed    = 300.0,
		size     = 10.0,
		sides    = 3,
	}
	append_elem(&bullets, bullet)
}
