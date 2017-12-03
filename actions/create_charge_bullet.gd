extends 'base_action.gd'

func _init():
	cooldown_time = 1

func activate(action_handler):
	self.icon = preload('res://bullets/charge_bullet/charge_bullet_sprite.tscn')
	var ChargeBullet = preload('res://bullets/charge_bullet.tscn')
	var b = ChargeBullet.instance()
	var pl = action_handler.get_parent()
	pl.get_parent().add_child(b)
	return b
