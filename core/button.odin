package core

import "globals"
import rl "vendor:raylib"

createButton :: proc(
	pos: rl.Vector2,
	size: rl.Vector2,
	text: cstring,
	callback: proc(),
	limitation: proc() -> bool = proc() -> bool {return true},
	fontSize: f32 = 20,
	defaultColor: rl.Color = rl.LIGHTGRAY,
	hoverColor: rl.Color = rl.GRAY,
	clickColor: rl.Color = rl.BLACK,
) {
	button := globals.Button {
		position     = pos,
		size         = size,
		text         = text,
		callback     = callback,
		fontSize     = fontSize,
		defaultColor = defaultColor,
		hoverColor   = hoverColor,
		clickColor   = clickColor,
		isClicked    = false,
		isHovered    = false,
		limitation   = limitation,
	}
	append_elem(&globals.buttons, button)
}

drawButton :: proc(button: globals.Button) {
	if !button.limitation() {
		return
	}
	origin := globals.Anchor.Center
	anchor := anchorToVec2(origin)
	rect := createRectangleV(button.position, button.size)

	backgroundColor := button.defaultColor
	if button.isHovered {
		backgroundColor = button.hoverColor
	}
	if button.isClicked {
		backgroundColor = button.clickColor
	}

	rl.DrawRectanglePro(rect, button.size * anchor, 0.0, backgroundColor)
	rl.DrawRectangleLinesEx(
		createRectangleV(button.position - button.size * anchor, button.size),
		2,
		rl.BLACK,
	)
	textSize := rl.MeasureTextEx(rl.GetFontDefault(), button.text, button.fontSize, 3)
	rl.DrawTextPro(
		rl.GetFontDefault(),
		button.text,
		button.position,
		textSize / 2,
		0.0,
		button.fontSize,
		3,
		rl.BLACK,
	)
}

updateButton :: proc(button: ^globals.Button) {
	origin := globals.Anchor.Center
	anchor := anchorToVec2(origin)
	mousePos := rl.GetMousePosition()

	button.isHovered = rl.CheckCollisionPointRec(
		mousePos,
		createRectangleV(button.position - button.size * anchor, button.size),
	)
	button.isClicked = button.isHovered && rl.IsMouseButtonPressed(.LEFT)

	if button.isClicked {
		button.callback()
	}
}

updateButtons :: proc() {
	for &button in globals.buttons {
		updateButton(&button)
	}
}

drawButtons :: proc() {
	for button in globals.buttons {
		drawButton(button)
	}
}
