extends 'base_action.gd'

func _init():
	cooldown_time = 4
	name = "guided_bullet"
	icon = preload("res://bullets/guided_bullet/guided_bullet_sprite.tscn")

func activate(action_handler):
	var GuidedBullet = preload('res://bullets/guided_bullet.tscn')
	var pl = action_handler.get_parent()
	pl.sfx.play("Special")
	var b = GuidedBullet.instance()
	b.set_pos(pl.get_pos())
	#b.fixed_speed = pl.get_look_dir().normalized() * 400
	pl.get_parent().add_child(b)