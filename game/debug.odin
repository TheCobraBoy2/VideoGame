package game

import "../core"

handleDebug :: proc() {
  if core.wasActionPressed(debugKeys, Action_Debug) {
    state.drawDebug = !state.drawDebug
  }
}