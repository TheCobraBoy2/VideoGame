package core

import "globals"

import "core:math"
import "core:math/rand"
import rl "vendor:raylib"

falling_behavior :: proc(p: ^globals.Particle) {
	gravity := rl.Vector2{0, 500.0} // pixels/sec^2
	p.velocity += gravity * rl.GetFrameTime()
	p.position += p.velocity * rl.GetFrameTime()
}

spring_behavior :: proc(p: ^globals.Particle) {
	// initial velocity already points upward
	gravity := rl.Vector2{0, 300.0}
	p.velocity += gravity * rl.GetFrameTime()
	p.position += p.velocity * rl.GetFrameTime()
}

emit_particles :: proc(
	pos: rl.Vector2,
	count: int,
	color: rl.Color,
	size: rl.Vector2,
	speed_range: rl.Vector2,
	life_range: rl.Vector2,
	behavior: proc(p: ^globals.Particle),
) {

	for i in 0 ..< count {
		angle := rand.float32_range(0, 2 * math.PI)
		speed := rand.float32_range(speed_range.x, speed_range.y)

		p := globals.Particle {
			position = pos,
			velocity = rl.Vector2{math.cos(angle) * speed, math.sin(angle) * speed},
			size     = size,
			color    = color,
			life     = rand.float32_range(life_range.x, life_range.y),
			update   = behavior,
		}
		append_elem(&globals.particles, p)
	}
}
