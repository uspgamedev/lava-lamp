extends 'base_action.gd'

func _init():
	cooldown_time = 5
	name = 'flamethrower'

func activate(action_handler, key):
	var Flamethrower = preload('res://area_effects/flamethrower.tscn')
	var b = Flamethrower.instance()
	var pl = action_handler.get_parent()
	b.hold_key = action_handler.unmap_key(key)
	b.angle = pl.get_look_dir().angle()
	pl.get_parent().add_child(b)
	return b