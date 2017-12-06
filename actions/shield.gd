extends 'base_action.gd'
const SHIELDTIME = 10

func _init():
	cooldown_time = 30
	name = "shield"
	self.icon = preload("res://effects/lightning/shield.tscn")
	auto_play = true

func activate(action_handler, key):
	var player = action_handler.get_parent()
	player.shield(SHIELDTIME)
