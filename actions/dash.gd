extends 'base_action.gd'
const DASHTIME = 0.1

func _init():
	cooldown_time = 3
	name = "dash"
	icon = preload("res://gui/icons/dash_icon.tscn")

func activate(action_handler):
	var player = action_handler.get_parent()
	player.dash(DASHTIME)
