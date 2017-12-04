extends 'follow_player.gd'

func hit(obj):
	if obj extends preload('res://bullets/bullet.gd'):
		if obj extends preload('res://bullets/ghost_bullet.gd'):
			get_parent().deal_damage(obj.damage)
			obj.queue_free()