extends Node

var knockback = 5000
var enemy_dmg = 1

func collided_with_player(player):
	var enemy = get_parent()
	var vec = player.position - enemy.position
	if (player.shieldTime != 0 and enemy.name != 'Ghost' and \
	                               enemy.name != 'Absorber' and \
	                               enemy.name != 'HardShielded'):
		enemy.deal_damage(enemy_dmg)
		enemy.speed += knockback * vec.normalized()
	else:
		player.speed += knockback * vec.normalized()
		player.deal_damage(enemy_dmg)
	player.dashTime = 0

func process_stunned(stun_time):
	var enemy = get_parent()
	enemy.stunned = 5
	enemy.get_node('Stunned').visible = true
	var t = enemy.get_node('Stunned/Timer')
	t.wait_time = enemy.stunned
	t.start()

func hit(obj):
	var enemy = get_parent()
	enemy.deal_damage(obj.damage)
	if (enemy.damage >= enemy.hp):
		enemy.queue_free()
	if obj is preload('res://bullets/bullet.gd'):
		if obj is preload('res://bullets/ion_bullet.gd'):
			process_stunned(3)
		if not obj is preload('res://bullets/tracer_bullet.gd'):
			obj.queue_free()

func think(dt, player):
	pass
