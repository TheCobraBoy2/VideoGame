package game

import "../core/globals"
import rl "vendor:raylib"

Player :: struct {
	using rectEntity: globals.RectEntity,
}

Enemy :: struct {
	using circleEntity: globals.CircleEntity,
	target:             ^globals.Entity,
}

Bullet :: struct {
	using polyEntity: globals.PolyEntity,
	direction:        rl.Vector2,
	friendly:         bool,
}

State :: struct {
	using time: globals.Time,
	drawDebug:  globals.DrawDebug,
}

state: State
player: Player
enemies: [dynamic]Enemy
bullets: [dynamic]Bullet
