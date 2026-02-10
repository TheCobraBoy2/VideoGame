package game

import "../core/globals"

Player :: struct {
  using entity : globals.Entity,
}

State :: struct {
  using time : globals.Time,
  drawDebug : globals.DrawDebug,
}

state : State
player : Player