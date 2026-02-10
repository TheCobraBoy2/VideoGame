package game

import rl "vendor:raylib"

draw :: proc() {
	drawEnemies()
	drawPlayer()
	drawBullets()
}
