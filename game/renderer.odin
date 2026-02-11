package game

draw :: proc() {
	drawEnemies()
	drawPlayer()
	drawBullets()
	if !state.paused {
		if startGen {
			drawStartLevel()
		}
	}
}

// Drawn on top of blur / shader
onTop :: proc() {
	if state.paused {
		drawPauseMenu()
	}
	if state.drawDebug {
		drawDebug()
	}
}
