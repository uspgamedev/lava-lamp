extends 'follow_player.gd'

const DIR = preload('res://characters/player/input/directions.gd')

func hit(obj):
	var enemy = get_parent()
	var d = enemy.get_look_dir_value()

	if obj is preload('res://bullets/bullet.gd'):
		if obj is preload('res://bullets/trap.gd') or obj is preload('res://bullets/tracer_bullet.gd'):
			.hit(obj)
		elif (d == DIR.UP and enemy.get_node('UpShield').overlaps_area(obj.get_node('Area2D'))) or \
		   (d == DIR.DOWN and enemy.get_node('DownShield').overlaps_area(obj.get_node('Area2D'))) or \
		   (d == DIR.LEFT and enemy.get_node('LeftShield').overlaps_area(obj.get_node('Area2D'))) or \
		   (d == DIR.RIGHT and enemy.get_node('RightShield').overlaps_area(obj.get_node('Area2D'))):
			obj.queue_free()
			enemy.get_node('Block').play()
		else:
			.hit(obj)
	elif obj is preload('res://area_effects/area_effect.gd'):
		.hit(obj)
