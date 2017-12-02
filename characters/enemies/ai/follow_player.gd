extends Node

var move_cooldown_max = 1
var move_cooldown = 0

var sp = 100

func think(dt, enemy, player):
	move_cooldown -= dt
	if move_cooldown <= 0:
		var vec = player.get_pos() - enemy.get_pos()
		enemy.move(sp * dt * vec.normalized())

func collided_with_player(enemy, player):
	var vec = player.get_pos() - enemy.get_pos()
	player.speed += 30 * sp * vec.normalized()
	player.deal_damage(1)
	move_cooldown = move_cooldown_max
