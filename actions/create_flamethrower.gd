extends 'base_action.gd'

func _init():
	cooldown_time = 1

func activate(action_handler):
	var Flamethrower = preload('res://area_effects/flamethrower.tscn')
	var b = Flamethrower.instance()
	var pl = action_handler.get_parent()
	b.set_pos(pl.get_pos())
	b.set_rot(pl.get_look_dir().angle())
	pl.get_parent().add_child(b)
	return b