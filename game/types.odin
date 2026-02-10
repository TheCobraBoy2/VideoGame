package game

import "../core/globals"

Player :: struct {
  using entity : globals.Entity
}

State :: struct {
  using time : globals.Time
}

state : State
player : Player