extends 'base_action.gd'

func activate(action_handler):
	print("Wormhole")
	var Wormhole = preload('res://bullets/wormhole.tscn')
	var pl = action_handler.get_parent()
	var wh1 = Wormhole.instance()
	wh1.set_pos(pl.get_pos())
	pl.get_parent().add_child(wh1)
	var wh2 = Wormhole.instance()
	wh2.set_pos(pl.get_node("../..").get_valid_position())
	pl.get_parent().add_child(wh2)
	wh1.set_brother(wh2)