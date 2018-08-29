extends 'follow_player.gd'

func hit(obj):
	if obj is preload('res://bullets/bullet.gd'):
		if obj is preload('res://bullets/ghost_bullet.gd'):
			get_parent().deal_damage(obj.damage)
			obj.queue_free()
