extends 'base_action.gd'

func _init():
	cooldown_time = 10
	name = "charge_bullet"
	icon = preload('res://bullets/charge_bullet/charge_bullet_sprite.tscn')
	
func activate(action_handler, key):
	var ChargeBullet = preload('res://bullets/charge_bullet.tscn')
	var b = ChargeBullet.instance()
	var pl = action_handler.get_parent()
	b.hold_key = key + KEY_A
	pl.get_parent().add_child(b)
	return b
