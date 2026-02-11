package game

import "../core"
import "core:fmt"
import "core:math"
import rl "vendor:raylib"

handleDebug :: proc() {
	if core.wasActionPressed(debugKeys, Action_Debug) {
		state.drawDebug = !state.drawDebug
	}
}

debugPos :: proc(c: f32) -> rl.Vector2 {
	return rl.Vector2{5, 5 + (c * 23)}
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

drawTargetLine :: proc() {
	if len(enemies) > 0 {
		rl.DrawLineEx(
			player.position,
			core.closestEntity(player, stripEnemiesToEntities())^.position,
			3,
			rl.RED,
		)
	}
}

drawBulletRay :: proc(position, direction: rl.Vector2, color: rl.Color) {
	if rl.Vector2Length(direction) == 0 {
		return
	}

	normalized_direction := rl.Vector2Normalize(direction)

	screen_width := f32(rl.GetScreenWidth())
	screen_height := f32(rl.GetScreenHeight())

	closest_distance := f32(1e30)
	hit_point := position

	if normalized_direction.x != 0 {
		distance := (0 - position.x) / normalized_direction.x
		intersection_y := position.y + normalized_direction.y * distance
		if distance > 0 &&
		   intersection_y >= 0 &&
		   intersection_y <= screen_height &&
		   distance < closest_distance {
			closest_distance = distance
			hit_point = rl.Vector2{0, intersection_y}
		}
	}

	if normalized_direction.x != 0 {
		distance := (screen_width - position.x) / normalized_direction.x
		intersection_y := position.y + normalized_direction.y * distance
		if distance > 0 &&
		   intersection_y >= 0 &&
		   intersection_y <= screen_height &&
		   distance < closest_distance {
			closest_distance = distance
			hit_point = rl.Vector2{screen_width, intersection_y}
		}
	}

	if normalized_direction.y != 0 {
		distance := (0 - position.y) / normalized_direction.y
		intersection_x := position.x + normalized_direction.x * distance
		if distance > 0 &&
		   intersection_x >= 0 &&
		   intersection_x <= screen_width &&
		   distance < closest_distance {
			closest_distance = distance
			hit_point = rl.Vector2{intersection_x, 0}
		}
	}

	if normalized_direction.y != 0 {
		distance := (screen_height - position.y) / normalized_direction.y
		intersection_x := position.x + normalized_direction.x * distance
		if distance > 0 &&
		   intersection_x >= 0 &&
		   intersection_x <= screen_width &&
		   distance < closest_distance {
			closest_distance = distance
			hit_point = rl.Vector2{intersection_x, screen_height}
		}
	}

	for enemy in enemies {
		to_enemy := enemy.position - position
		projection := to_enemy.x * normalized_direction.x + to_enemy.y * normalized_direction.y

		if projection <= 0 {
			continue
		}

		closest_point := position + normalized_direction * projection
		distance_to_center := rl.Vector2Distance(closest_point, enemy.position)

		if distance_to_center > enemy.size {
			continue
		}

		offset := math.sqrt(enemy.size * enemy.size - distance_to_center * distance_to_center)
		hit_distance := projection - offset

		if hit_distance > 0 && hit_distance < closest_distance {
			closest_distance = hit_distance
			hit_point = position + normalized_direction * hit_distance
		}
	}
	rl.DrawLineEx(position, hit_point, 2, color)
}

drawBulletRays :: proc() {
	if len(bullets) > 0 {
		for bullet in bullets {
			drawBulletRay(bullet.position, bullet.direction, rl.BLACK)
		}
	}
}

textSize :: 24
spacing :: 3
color :: rl.BLACK

drawDebug :: proc() {
	enemyCount: i32 = STARTING_ENEMY_COUNT
	enemySpeed: f32 = STARTING_ENEMY_SPEED
	if state.level > 1 {
		enemyCount = cast(i32)(cast(f32)STARTING_ENEMY_COUNT *
			math.pow(1.0 + ENEMY_INCREASE, cast(f32)(state.level - 1)))
		enemySpeed =
			math.round(
				(STARTING_ENEMY_SPEED *
					math.pow(1.0 + ENEMY_SPEED_INCREASE, cast(f32)(state.level - 1))) *
				100.0,
			) /
			100.0
	}
	curInd = 1.0
	speed := fmt.ctprintf("%.2f", enemySpeed)
	aSpeed := fmt.ctprintf("%.1f", math.round(player.attackSpeed * 10.0) / 10.0)
	now := fmt.ctprintf("%.3f", math.round(state.now * 1000.0) / 1000.0)
	drawDebugText("Session Time:", now)
	drawDebugText("Level Enemies:", enemyCount)
	drawDebugText("Remaining Enemies:", len(enemies))
	drawDebugText("Enemy Speed: ~", speed)
	drawDebugText("Level:", state.level)
	drawDebugText("Bullet Count:", len(bullets))
	drawDebugText("Attack Speed:", aSpeed)
	drawDebugText("Alive:", player.alive)
	drawBulletRays()
	drawTargetLine()
}
