extends 'base_action.gd'

func _init():
	cooldown_time = 10
	name = "trap"
	icon = preload("res://scenario/props/trap_sprite.tscn")
	auto_play = true

func activate(action_handler, key):
	var Trap = preload('res://bullets/trap.tscn')
	var b = Trap.instance()
	var pl = action_handler.get_parent()
	b.set_position(pl.get_position())
	b.set_rotation(PI/2)
	b.speed = Vector2()
	pl.get_parent().add_child(b)
	return null
