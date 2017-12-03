extends 'follow_player.gd'

func _ready():
	knockback = 8000
	enemy_dmg = 2

func hit_by_bullet(bullet):
	var enemy = get_parent()
	if bullet extends preload('res://bullets/trap.gd'):
		.hit_by_bullet(bullet)
	elif bullet extends preload('res://bullets/guided_bullet.gd'):
		bullet.guided_speed = -bullet.guided_speed
		bullet.enemy = null
	else:
		bullet.speed = -bullet.speed