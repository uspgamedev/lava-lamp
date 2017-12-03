extends 'base_action.gd'

func _init():
	cooldown_time = .2

func activate(action_handler):
	self.icon = preload("res://bullets/simple_bullet_sprite.tscn")
	var SimpleBullet = preload('res://bullets/simple_bullet.tscn')
	var pl = action_handler.get_parent()
	var b = SimpleBullet.instance()
	b.set_script(preload('res://bullets/guided_bullet.gd'))
	b.set_pos(pl.get_pos() + Vector2(0, -20))
	#b.fixed_speed = pl.get_look_dir().normalized() * 400
	pl.get_parent().add_child(b)