extends 'base_action.gd'

func _init():
	cooldown_time = .4
	name = "simple_bullet"
	icon = preload("res://bullets/simple_bullet_sprite.tscn")

func activate(action_handler, key):
	var SimpleBullet = preload('res://bullets/simple_bullet.tscn')
	var b = SimpleBullet.instance()
	var pl = action_handler.get_parent()
	pl.sfx.play("Shoot")
	b.set_position(pl.get_position() + 10*pl.get_look_vec())
	b.speed = pl.get_look_dir().normalized() * 400
	pl.get_parent().add_child(b)
	return null
