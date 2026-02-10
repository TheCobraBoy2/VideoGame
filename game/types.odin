package game

import "../core/globals"
import rl "vendor:raylib"

STARTING_ENEMY_COUNT :: 3
ENEMY_INCREASE :: 0.25
STARTING_ENEMY_SPEED :: 70.0
ENEMY_SPEED_INCREASE :: 0.005

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
	level:      i32,
	paused:     bool,
}

state: State
player: Player
enemies: [dynamic]Enemy
bullets: [dynamic]Bullet

stripEnemiesToEntities :: proc() -> []globals.Entity {
	a: []globals.Entity = make([]globals.Entity, len(enemies))
	for e, i in enemies {
		a[i] = e
	}
	return a
}
