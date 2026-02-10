package game

import "../core"
import rl "vendor:raylib"

drawPlayer :: proc() {
	core.drawRectPro(player.position, player.size, player.color, player.rotation, player.origin)
}

playerMovement :: proc() {
	dir: rl.Vector2 = {0, 0}

	if core.isActionDown(playerKeys, Action_MoveUp) {
		dir += {0, -1}
	}
	if core.isActionDown(playerKeys, Action_MoveDown) {
		dir += {0, 1}
	}
	if core.isActionDown(playerKeys, Action_MoveLeft) {
		dir += {-1, 0}
	}
	if core.isActionDown(playerKeys, Action_MoveRight) {
		dir += {1, 0}
	}

	dir = rl.Vector2Normalize(dir)
	player.position += dir * (player.speed * state.dt)
	half := player.size * 0.5

	min := half
	max := rl.Vector2 {
		cast(f32)rl.GetScreenWidth() - half.x,
		cast(f32)rl.GetScreenHeight() - half.y,
	}

	player.position = rl.Vector2Clamp(player.position, min, max)
}
