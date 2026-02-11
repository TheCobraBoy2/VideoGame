package game

import "../core"
import "core:fmt"
import rl "vendor:raylib"

handleDebug :: proc() {
	if core.wasActionPressed(debugKeys, Action_Debug) {
		state.drawDebug = !state.drawDebug
	}
}

debugPos :: proc(c: f32) -> rl.Vector2 {
	return rl.Vector2{5, 5 + (c * 20)}
}

curInd: f32 = 1.0

drawDebugText :: proc(text: string, val: any) {
	rl.DrawTextEx(
		rl.GetFontDefault(),
		fmt.ctprint(text, val),
		debugPos(curInd),
		textSize,
		spacing,
		color,
	)
	curInd += 1
}

textSize :: 24
spacing :: 3
color :: rl.BLACK

drawDebug :: proc() {
	curInd = 1.0
	drawDebugText("Remaining Enemies: ", len(enemies))
	drawDebugText("Level: ", state.level)
}
