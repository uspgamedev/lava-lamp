extends 'base_action.gd'

func _init():
	cooldown_time = 15
	name = 'flamethrower'

func activate(action_handler, key):
	var Flamethrower = preload('res://area_effects/flamethrower.tscn')
	var b = Flamethrower.instance()
	var pl = action_handler.get_parent()
	b.set_pos(pl.get_pos() + Vector2(0, -20))
	b.hold_key = key + KEY_A
	b.set_rot(pl.get_look_dir().angle())
	pl.get_parent().add_child(b)
	return b