extends 'base_action.gd'

func _init():
	cooldown_time = .4

func activate(action_handler):
	self.icon = preload("res://bullets/tracer_bullet/tracer_bullet_sprite.tscn")
	var TracerBullet = preload('res://bullets/tracer_bullet.tscn')
	var b = TracerBullet.instance()
	var pl = action_handler.get_parent()
	b.set_pos(pl.get_pos() + Vector2(0, -20))
	b.speed = pl.get_look_dir().normalized() * 400
	pl.get_parent().add_child(b)
	return null
