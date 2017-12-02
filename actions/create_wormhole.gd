extends 'base_action.gd'

func activate(action_handler):
	print("Wormhole")
	var Wormhole = preload('res://bullets/wormhole.tscn')
	var b = Wormhole.instance()
	var pl = action_handler.get_parent()
	b.set_pos(pl.get_pos())
	pl.get_parent().add_child(b)