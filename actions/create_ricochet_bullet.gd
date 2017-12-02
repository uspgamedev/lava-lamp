extends 'base_action.gd'

func _init():
	cooldown_time = .2

func activate(action_handler):
	print("Ricochet Bullet")
	var RicochetBullet = preload('res://bullets/ricochet_bullet.tscn')
	var b = RicochetBullet.instance()
	var pl = action_handler.get_parent()
	b.set_pos(pl.get_pos())
	b.speed = pl.get_look_dir().normalized() * 400
	pl.get_parent().add_child(b)
