package game

update :: proc() {
	bulletsMovement()
	playerMovement()
	enemiesMovement()
	handleDebug()
}
