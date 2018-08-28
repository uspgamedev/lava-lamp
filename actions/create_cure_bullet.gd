extends 'base_action.gd'

const CureBullet = preload('res://bullets/cure_bullet.tscn')

func _init():
	cooldown_time = .3
	name = "cure_bullet"
	icon = preload("res://bullets/cure_bullet/cure_bullet_sprite.tscn")

func activate(action_handler, key):
	#self.icon = preload("res://bullets/cure_bullet_icon.tscn")
	var b = CureBullet.instance()
	var pl = action_handler.get_parent()
	b.set_position(pl.get_position())
	b.speed = pl.get_look_dir().normalized() * 600
	pl.get_parent().add_child(b)
