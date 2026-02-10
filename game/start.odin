package game

import "../core"
import "../core/globals"
import rl "vendor:raylib"

initializeGame :: proc() {
	state.drawDebug = false
	player = Player {
		position = core.centerOfScreen(),
		size     = rl.Vector2{80, 80},
		color    = rl.GREEN,
		origin   = globals.Anchor.Center,
		rotation = 0.0,
		speed    = 250.0,
	}
	e := generateEnemy()
	generateBullet(player, e, true)
}
