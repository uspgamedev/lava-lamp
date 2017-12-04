extends 'base_action.gd'

const CureBullet = preload('res://bullets/cure_bullet.tscn')

func _init():
	cooldown_time = .3
	name = "cure_bullet"

func activate(action_handler):
	#self.icon = preload("res://bullets/cure_bullet_icon.tscn")
	var b = CureBullet.instance()
	var pl = action_handler.get_parent()
	b.set_pos(pl.get_pos())
	b.speed = pl.get_look_dir().normalized() * 600
	pl.get_parent().add_child(b)