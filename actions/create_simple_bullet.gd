extends 'base_action.gd'

func _init():
	cooldown_time = .4
	name = "simple_bullet"
	icon = preload("res://bullets/simple_bullet_sprite.tscn")

func activate(action_handler):
	var SimpleBullet = preload('res://bullets/simple_bullet.tscn')
	var b = SimpleBullet.instance()
	var pl = action_handler.get_parent()
	pl.sfx.play("Shoot")
	b.set_pos(pl.get_pos())
	b.speed = pl.get_look_dir().normalized() * 400
	pl.get_parent().add_child(b)
	return null
