extends 'base_action.gd'

const GhostBullet = preload('res://bullets/ghost_bullet.tscn')

func _init():
	cooldown_time = 1.5
	name = "ghost_bullet"
	icon = preload("res://bullets/ghost_bullet/ghost_bullet.tscn")

func activate(action_handler, key):
	var b = GhostBullet.instance()
	var pl = action_handler.get_parent()
	b.set_position(pl.get_position())
	b.speed = pl.get_look_dir().normalized() * 300
	pl.get_parent().add_child(b)
