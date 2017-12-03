extends Node

var knockback = 5000

func collided_with_player(player):
	var enemy = get_parent()
	var vec = player.get_pos() - enemy.get_pos()
	player.speed += knockback * vec.normalized()
	player.deal_damage(1)
	player.dashTime = 0


func hit_by_bullet(bullet):
	var enemy = get_parent()
	enemy.deal_damage(bullet.damage)
	if not bullet extends preload('res://bullets/tracer_bullet.gd'):
		bullet.queue_free()

func think(dt, player):
	pass