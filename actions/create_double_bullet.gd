extends 'base_action.gd'

func _init():
	cooldown_time = .6

func activate(action_handler):
	self.icon = preload("res://bullets/simple_bullet_sprite.tscn")
	var SimpleBullet = preload('res://bullets/simple_bullet.tscn')
	var b1 = SimpleBullet.instance()
	var b2 = SimpleBullet.instance()
	var pl = action_handler.get_parent()
	b1.set_pos(pl.get_pos() + Vector2(0, -20))
	b2.set_pos(pl.get_pos() + Vector2(0, -20))
	b1.speed = pl.get_look_dir().rotated(PI/6).normalized() * 400
	b2.speed = pl.get_look_dir().rotated(-PI/6).normalized() * 400
	pl.get_parent().add_child(b1)
	pl.get_parent().add_child(b2)