package game

import "../core"
import "../core/globals"
import rl "vendor:raylib"

blur: rl.Shader

initializeGame :: proc() {
	state.drawDebug = false
	state.paused = false
	player = Player {
		position = core.centerOfScreen(),
		size     = rl.Vector2{80, 80},
		color    = rl.GREEN,
		origin   = globals.Anchor.Center,
		rotation = 0.0,
		speed    = 250.0,
	}

	blur := rl.LoadShader()

	generateWave()
}
