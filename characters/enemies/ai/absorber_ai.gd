extends 'follow_player.gd'

func _init():
	sp = 7000

func hit(obj):
	var enemy = get_parent()
	if obj extends preload('res://bullets/ion_bullet.gd'):
		process_stunned(5)
		obj.queue_free()
	else:
		if enemy.stunned > 0:
			.hit(obj)
		elif obj extends preload('res://bullets/bullet.gd'):
			obj.queue_free()