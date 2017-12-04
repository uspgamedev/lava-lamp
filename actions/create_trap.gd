extends 'base_action.gd'

func _init():
	cooldown_time = 1
	name = "trap"

func activate(action_handler):
	self.icon = preload("res://scenario/props/trap_sprite.tscn")
	var Trap = preload('res://bullets/trap.tscn')
	var b = Trap.instance()
	var pl = action_handler.get_parent()
	pl.sfx.play("Special")
	b.set_pos(pl.get_pos())
	b.speed = Vector2()
	pl.get_parent().add_child(b)
	return null