package game

import "../core"
import "../core/globals"
import rl "vendor:raylib"

blur: rl.Shader
startGen: bool

initializeGame :: proc() {
	createCooldowns()
	state.drawDebug = false
	state.paused = false
	state.level = 0
	startGen = false
	player = Player {
		position    = core.centerOfScreen(),
		size        = rl.Vector2{80, 80},
		color       = rl.GREEN,
		origin      = globals.Anchor.Center,
		rotation    = 0.0,
		speed       = 250.0,
		attackSpeed = 1.0,
		alive       = true,
	}
	initPause()
}
