extends 'base_action.gd'

func _init():
	cooldown_time = .4

func activate(action_handler):
	self.icon = preload("res://bullets/simple_bullet_sprite.tscn")
	var SimpleBullet = preload('res://bullets/simple_bullet.tscn')
	var b = SimpleBullet.instance()
	var pl = action_handler.get_parent()
	b.set_script(preload('res://bullets/tracer_bullet.gd'))
	b.set_pos(pl.get_pos() + Vector2(0, -20))
	b.fixed_speed = pl.get_look_dir().normalized() * 400
	pl.get_parent().add_child(b)
