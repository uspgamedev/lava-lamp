extends 'base_action.gd'

func activate(action_handler):
	print("Simple Bullet")
	var SimpleBullet = preload('res://bullets/simple_bullet.tscn')
	var b = SimpleBullet.instance()
	var pl = action_handler.get_parent()
	b.set_pos(pl.get_pos())
	b.fixed_speed = pl.speed.normalized() * 200
	pl.get_parent().add_child(b)