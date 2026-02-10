package core

import rl "vendor:raylib"

Action :: distinct u32
KeyMap :: map[Action][]rl.KeyboardKey

isActionDown :: proc(keymap: KeyMap, action: Action) -> bool {
  if keys, ok := keymap[action]; ok {
    for key in keys {
      if rl.IsKeyDown(key) {
        return true
      }
    }
  }
  return false
}

wasActionPressed :: proc(keymap: KeyMap, action: Action) -> bool {
  if keys, ok := keymap[action]; ok {
    for key in keys {
      if rl.IsKeyPressed(key) {
        return true
      }
    }
  }
  return false
}