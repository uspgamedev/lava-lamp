extends 'base_action.gd'

func activate(action_handler):
	self.icon = preload("res://scenario/props/trap_sprite.tscn")
	print("Trap")
	var Trap = preload('res://bullets/trap.tscn')
	var b = Trap.instance()
	var pl = action_handler.get_parent()
	b.set_pos(pl.get_pos())
	b.speed = Vector2()
	pl.get_parent().add_child(b)