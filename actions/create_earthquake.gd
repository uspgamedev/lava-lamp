extends 'base_action.gd'

func _init():
	cooldown_time = 25
	name = "earthquake"
	auto_play = true

func activate(action_handler, key):
	self.icon = preload("res://effects/lightning/sprite.tscn")
	var Earthquake = preload('res://area_effects/earthquake.tscn')
	var b = Earthquake.instance()
	var pl = action_handler.get_parent()
	b.set_pos(pl.get_pos())
	pl.get_parent().add_child(b)
	return null
