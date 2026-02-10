package game

update :: proc() {
  playerMovement()
  enemiesMovement()
  handleDebug()
}