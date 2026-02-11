package core

import "core:fmt"
import "globals"
import rl "vendor:raylib"

drawDebug: ^globals.DrawDebug
paused: ^globals.Paused
blurAmount: f32 = 2.0

draw :: proc(external: proc(), topExternal: proc()) {
	rl.BeginTextureMode(sceneTarget)
	rl.ClearBackground(rl.BLUE)
	for p in globals.particles {
		rl.DrawCircleV(p.position, rl.Vector2Length(p.size), p.color)
	}
	external()
	rl.EndTextureMode()

	rl.BeginDrawing()
	rl.ClearBackground(rl.BLACK)

	if paused^ {
		rl.SetShaderValue(blur, blurLoc, &blurAmount, rl.ShaderUniformDataType.FLOAT)
		rl.BeginShaderMode(blur)
	}

	rl.DrawTextureRec(
		sceneTarget.texture,
		rl.Rectangle {
			0,
			0,
			cast(f32)sceneTarget.texture.width,
			-cast(f32)sceneTarget.texture.height,
		},
		rl.Vector2{0, 0},
		rl.WHITE,
	)

	if paused^ {
		rl.EndShaderMode()
	}

	topExternal()

	if drawDebug^ {
		rl.DrawTextEx(
			rl.GetFontDefault(),
			fmt.ctprint("FPS:", rl.GetFPS()),
			rl.Vector2{5, 5},
			24,
			3,
			rl.BLACK,
		)
	}
	rl.EndDrawing()
}

drawRectPro :: proc(
	pos, size: rl.Vector2,
	color: rl.Color,
	rotation: f32,
	origin: globals.Anchor,
) {
	anchor := anchorToVec2(origin)
	rl.DrawRectanglePro(createRectangleV(pos, size), size * anchor, rotation, color)
	if drawDebug^ {
		rl.DrawRectangleLinesEx(createRectangleV(pos - size * anchor, size), 3, rl.RED)
		rl.DrawCircleV(pos, 3, rl.RED)
	}
}

drawCircle :: proc(pos: rl.Vector2, size: f32, color: rl.Color) {
	rl.DrawCircleV(pos, size, color)
	if drawDebug^ {
		rl.DrawCircleV(pos, 3, rl.WHITE)
		rl.DrawCircleLinesV(pos, size, rl.WHITE)
		rl.DrawCircleLinesV(pos, size + 0.5, rl.WHITE)
		rl.DrawCircleLinesV(pos, size + 1, rl.WHITE)
	}
}

drawRotatedHitbox :: proc(center: rl.Vector2, radius, rotation: f32) {
	half := rl.Vector2{radius, radius}

	corners := [4]rl.Vector2 {
		center + rl.Vector2{-half.x, -half.y},
		center + rl.Vector2{half.x, -half.y},
		center + rl.Vector2{half.x, half.y},
		center + rl.Vector2{-half.x, half.y},
	}

	for i in 0 ..< 4 {
		corners[i] = rl.Vector2Rotate(corners[i] - center, rotation) + center
	}

	for i in 0 ..< 4 {
		j := (i + 1) % 4
		rl.DrawLineV(corners[i], corners[j], rl.RED)
	}
}

drawPolygon :: proc(pos: rl.Vector2, sides: i32, radius, rotation: f32, color: rl.Color) {
	rl.DrawPoly(pos, sides, radius, rotation, color)
	if drawDebug^ {
		drawRotatedHitbox(pos, 4, rotation)
	}
}

drawButton :: proc(
	pos: rl.Vector2,
	size: rl.Vector2,
	text: cstring,
	callback: proc(),
	fontSize: f32 = 20,
	defaultColor: rl.Color = rl.LIGHTGRAY,
	hoverColor: rl.Color = rl.GRAY,
	clickColor: rl.Color = rl.BLACK,
) {
	origin := globals.Anchor.Center
	anchor := anchorToVec2(origin)
	mousePos := rl.GetMousePosition()
	rect := createRectangleV(pos, size)

	isHovered := rl.CheckCollisionPointRec(mousePos, createRectangleV(pos - size * anchor, size))
	isClicked := isHovered && rl.IsMouseButtonPressed(.LEFT)

	backgroundColor := defaultColor
	if isHovered {
		backgroundColor = hoverColor
	}
	if isClicked {
		backgroundColor = clickColor
	}

	rl.DrawRectanglePro(rect, size * anchor, 0.0, backgroundColor)
	rl.DrawRectangleLinesEx(createRectangleV(pos - size * anchor, size), 2, rl.BLACK)

	textSize := rl.MeasureTextEx(rl.GetFontDefault(), text, fontSize, 3)
	rl.DrawTextPro(rl.GetFontDefault(), text, pos, textSize / 2, 0.0, fontSize, 3, rl.BLACK)

	if isClicked {
		callback()
	}
}
