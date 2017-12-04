extends 'mage_ai.gd'

var teleport_time = 5

func _init():
	bullet_speed = 500

func think(dt, player):
	var enemy = get_parent()
	teleport_time -= dt
	if teleport_time <= 0:
		teleport_time = rand_range(4, 10)
		var b = MageBullet.instance()
		var main = get_node('/root/Main')
		var pos = null
		for tries in range(10):
			var p = main.get_valid_position()
			b.set_pos(p)
			if not b.test_move(player.get_pos() - p):
				pos = p
				break
		if pos == null:
			pos = main.get_valid_position()
		enemy.set_pos(pos)
		enemy.emit_signal('teleporting')
		shoot_cd = 1
		dest = null
		walk_cd = 2.5
	.think(dt, player)