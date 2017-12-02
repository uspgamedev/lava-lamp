extends 'base_action.gd'
const DASHTIME = 0.1

func _init():
	cooldown_time = 0.35

func activate(action_handler):
	var player = action_handler.get_parent()
	player.dashTime = DASHTIME