package game

draw :: proc() {
	drawEnemies()
	drawPlayer()
	drawBullets()
}

// Drawn on top of blur / shader
onTop :: proc() {
	if state.paused {
		drawPauseMenu()
	}
}
