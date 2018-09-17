extends 'base_action.gd'

func _init():
	cooldown_time = 2.5
	name = "wormhole"
	icon = preload('res://scenario/props/wormhole/wormhole_sprite.tscn')
	auto_play = true

func activate(action_handler, key):
	var Wormhole = preload('res://bullets/wormhole.tscn')
	var pl = action_handler.get_parent()
	var wh1 = Wormhole.instance()
	wh1.set_position(pl.get_position())
	wh1.speed = Vector2()
	pl.get_parent().add_child(wh1)
	pl.sfx.get_node("Special").play()
	var wh2 = Wormhole.instance()
	wh2.set_position(pl.get_node("../..").get_valid_position())
	wh2.speed = Vector2()
	pl.get_parent().add_child(wh2)
	wh1.set_brother(wh2)
	return null
