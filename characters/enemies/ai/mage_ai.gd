extends 'base_ai.gd'

var shoot_cd = 2

var MageBullet = preload('res://bullets/mage_bullet.tscn')

var dest = null

var walk_cd = 2
var bullet_speed = 350

func think(dt, player):
	var enemy = get_parent()
	shoot_cd -= dt
	if shoot_cd <= 0:
		shoot_cd = rand_range(1.4, 2.1)
		var b = MageBullet.instance()
		b.set_pos(enemy.get_pos())
		b.speed = (player.get_pos() - enemy.get_pos()).normalized() * bullet_speed
		player.get_parent().add_child(b)
	walk_cd -= dt
	if walk_cd <= 0:
		walk_cd = rand_range(5, 8)
		var main = get_node('/root/Main')
		for i in range(10):
			var p = main.get_valid_position()
			if not enemy.test_move(p - enemy.get_pos()):
				dest = p
				break
	if dest != null:
		if dest.distance_squared_to(enemy.get_pos()) < 3 * 3:
			dest = null
		else:
			enemy.speed += (dest - enemy.get_pos()).normalized() * 150

func hit(obj):
	if obj extends preload('res://bullets/trap.gd'):
		return
	.hit(obj)