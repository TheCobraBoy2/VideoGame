package game

import "core:fmt"
import "../core"

handleDebug :: proc() {
  if core.wasActionPressed(debugKeys, Action_Debug) {
    state.drawDebug = !state.drawDebug
  }
}