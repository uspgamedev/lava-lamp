extends 'base_action.gd'

func _init():
	cooldown_time = 1.5
	name = "shotgun_bullet"
	icon = preload("res://bullets/shrapnel_bullet/sprite.tscn")
	
func activate(action_handler, key):
	var ShotgunBullet = preload('res://bullets/shotgun_bullet.tscn')
	
	var bs = []
	var pl = action_handler.get_parent()
	for i in range(5):
		bs.push_back(ShotgunBullet.instance())
		bs[i].set_position(pl.get_position())
		bs[i].speed = pl.get_look_dir().rotated(PI/6 - i*PI/12).normalized() * 500
		bs[i].damage = 0.5
		pl.get_parent().add_child(bs[i])
	pl.sfx.get_node("Shotgun").play()
	pl.delayed_reload()
	return null
