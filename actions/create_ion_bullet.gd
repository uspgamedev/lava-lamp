extends 'base_action.gd'

func _init():
	cooldown_time = 5
	name = "ion_bullet"
	icon = preload('res://bullets/ion_bullet/ion_bullet_sprite.tscn')

func activate(action_handler, key):
	var ion = preload('res://bullets/ion_bullet.tscn').instance()
	var pl = action_handler.get_parent()
	ion.set_pos(pl.get_pos())
	ion.speed = pl.get_look_dir().normalized() * 500
	pl.get_parent().add_child(ion)
