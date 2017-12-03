extends 'follow_player.gd'

const DIR = preload('res://characters/player/input/directions.gd')

func hit_by_bullet(bullet):
	var enemy = get_parent()
	var d = enemy.get_look_dir_value()
	
	if (d == DIR.UP and enemy.get_node('UpShield').overlaps_area(bullet.get_node('Area2D'))) or \
	   (d == DIR.DOWN and enemy.get_node('DownShield').overlaps_area(bullet.get_node('Area2D'))) or \
	   (d == DIR.LEFT and enemy.get_node('LeftShield').overlaps_area(bullet.get_node('Area2D'))) or \
	   (d == DIR.RIGHT and enemy.get_node('RightShield').overlaps_area(bullet.get_node('Area2D'))):
		if bullet extends preload('res://bullets/trap.gd'):
			.hit_by_bullet(enemy, bullet)
		else:
			bullet.queue_free()
	else:
		.hit_by_bullet(bullet)