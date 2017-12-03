extends 'base_action.gd'

func _init():
	cooldown_time = .2
	name = "guided_bullet"

func activate(action_handler):
	self.icon = preload("res://bullets/guided_bullet/guided_bullet_sprite.tscn")
	var GuidedBullet = preload('res://bullets/guided_bullet.tscn')
	var pl = action_handler.get_parent()
	var b = GuidedBullet.instance()
	b.set_pos(pl.get_pos())
	#b.fixed_speed = pl.get_look_dir().normalized() * 400
	pl.get_parent().add_child(b)