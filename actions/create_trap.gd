extends 'base_action.gd'

func activate(action_handler):
	print("Trap")
	var Trap = preload('res://bullets/trap.tscn')
	var b = Trap.instance()
	var pl = action_handler.get_parent()
	b.set_pos(pl.get_pos())
	pl.get_parent().add_child(b)