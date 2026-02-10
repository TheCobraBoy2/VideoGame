package main

import "core"
import "game"
import rl "vendor:raylib"

main :: proc() {
	core.startWindow("Video Game")
	defer core.killWindow()

	game.initializeGame()
	core.drawDebug = &game.state.drawDebug
	core.paused = &game.state.paused

	for !rl.WindowShouldClose() {
		core.update(game.update, &game.state.time)
		core.draw(game.draw, game.onTop)
	}
}
