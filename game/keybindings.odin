#+feature dynamic-literals
package game

import "../core"

Action_MoveUp :: core.Action(1)
Action_MoveDown :: core.Action(2)
Action_MoveLeft :: core.Action(3)
Action_MoveRight :: core.Action(4)
Action_Menu :: core.Action(5)
Action_Debug :: core.Action(6)

playerKeys: core.KeyMap = {
	Action_MoveUp    = {.W, .UP},
	Action_MoveDown  = {.S, .DOWN},
	Action_MoveLeft  = {.A, .LEFT},
	Action_MoveRight = {.D, .RIGHT},
	Action_Menu      = {.ESCAPE},
}

debugKeys: core.KeyMap = {
	Action_Debug = {.F2},
}
