extends 'base_action.gd'
const SHIELDTIME = 5

func _init():
	cooldown_time = 10
	name = "shield"

func activate(action_handler):
	var player = action_handler.get_parent()
	player.shield(SHIELDTIME)
