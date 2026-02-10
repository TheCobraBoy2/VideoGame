package core

import rl "vendor:raylib"

import "globals"

sceneTarget: rl.RenderTexture2D

blur: rl.Shader
blurLoc: i32

startWindow :: proc(title: cstring) {
	rl.SetTargetFPS(globals.TARGET_FPS)
	rl.InitWindow(globals.WINDOW_WIDTH, globals.WINDOW_HEIGHT, title)
	rl.SetExitKey(globals.EXIT_KEY)
	sceneTarget = rl.LoadRenderTexture(rl.GetScreenWidth(), rl.GetScreenHeight())
	blur = rl.LoadShader(nil, "resources/shaders/blur.fs")
	blurLoc = rl.GetShaderLocation(blur, "blurSize")
}

killWindow :: proc() {
	rl.CloseWindow()
}
