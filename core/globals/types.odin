// Contains some base types that can be used for games

package globals

import rl "vendor:raylib"

Time :: struct {
	now: f32,
	dt:  f32,
}

DrawDebug :: bool
Paused :: bool

Entity :: struct {
	position: rl.Vector2,
	color:    rl.Color,
	speed:    f32,
}

RectEntity :: struct {
	using entity: Entity,
	size:         rl.Vector2,
	origin:       Anchor,
	rotation:     f32,
}

PolyEntity :: struct {
	using entity: Entity,
	sides:        i32,
	size:         f32,
	rotation:     f32,
}

CircleEntity :: struct {
	using entity: Entity,
	size:         f32,
}

Particle :: struct {
	position: rl.Vector2,
	velocity: rl.Vector2,
	size:     rl.Vector2,
	color:    rl.Color,
	life:     f32,
	update:   proc(p: ^Particle),
}

Cooldown :: struct {
	time:       f32,
	duration:   ^f32,
	callback:   proc(),
	limitation: proc() -> bool,
}

particles: [dynamic]Particle
cooldowns: [dynamic]Cooldown

Anchor :: enum {
	TopLeft,
	Top,
	TopRight,
	Left,
	Center,
	Right,
	BottomLeft,
	Bottom,
	BottomRight,
}

Anchor_Vectors := [Anchor]rl.Vector2 {
	.TopLeft     = {0.0, 0.0},
	.Top         = {0.5, 0.0},
	.TopRight    = {1.0, 0.0},
	.Left        = {0.0, 0.5},
	.Center      = {0.5, 0.5},
	.Right       = {1.0, 0.5},
	.BottomLeft  = {0.0, 1.0},
	.Bottom      = {0.5, 1.0},
	.BottomRight = {1.0, 1.0},
}
