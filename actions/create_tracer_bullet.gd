extends 'base_action.gd'

func _init():
	cooldown_time = 5
	name = "tracer_bullet"
	self.icon = preload("res://bullets/tracer_bullet/tracer_bullet_sprite.tscn")

func activate(action_handler, key):
	var TracerBullet = preload('res://bullets/tracer_bullet.tscn')
	var b = TracerBullet.instance()
	var pl = action_handler.get_parent()
	pl.sfx.play("Special")
	b.set_pos(pl.get_pos())
	b.speed = pl.get_look_dir().normalized() * 400
	pl.get_parent().add_child(b)
	return null
