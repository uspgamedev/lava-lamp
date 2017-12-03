extends Node

var knockback = 5000
var enemy_dmg = 1

func collided_with_player(player):
	var enemy = get_parent()
	var vec = player.get_pos() - enemy.get_pos()
	player.speed += knockback * vec.normalized()
	player.deal_damage(enemy_dmg)
	player.dashTime = 0


func hit_by_bullet(bullet):
	var enemy = get_parent()
	enemy.deal_damage(bullet.damage)
	if bullet extends preload('res://bullets/ion_bullet.gd'):
		enemy.stunned = 3
	if not bullet extends preload('res://bullets/tracer_bullet.gd'):
		bullet.queue_free()

func think(dt, player):
	pass