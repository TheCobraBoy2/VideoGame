package game

import "../core"
import rl "vendor:raylib"

handlePause :: proc() {
	if core.wasActionPressed(globalKeys, Action_Menu) {
		state.paused = !state.paused
	}
}

drawPauseMenu :: proc() {
	font := rl.GetFontDefault()
	text: cstring = "Paused"
	fontSize: f32 = 102.0
	spacing: f32 = 5.0

	size := rl.MeasureTextEx(font, text, fontSize, spacing)

	pos := rl.Vector2{cast(f32)rl.GetScreenWidth() * 0.5, cast(f32)rl.GetScreenHeight() * 0.05}

	origin := rl.Vector2 {
		size.x * 0.5, // center horizontally
		0.0, // top edge
	}

	rl.DrawTextPro(font, text, pos, origin, 0.0, fontSize, spacing, rl.WHITE)
}
