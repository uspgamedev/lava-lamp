extends Node

var knockback = 5000
var enemy_dmg = 1

func collided_with_player(player):
	var enemy = get_parent()
	var vec = player.get_pos() - enemy.get_pos()
	player.speed += knockback * vec.normalized()
	player.deal_damage(enemy_dmg)
	player.dashTime = 0

func hit(obj):
	var enemy = get_parent()
	enemy.deal_damage(obj.damage)
	if (enemy.damage >= enemy.hp):
		enemy.queue_free()
	if obj extends preload('res://bullets/bullet.gd'):
		if obj extends preload('res://bullets/ion_bullet.gd'):
			enemy.stunned = 3
		if not obj extends preload('res://bullets/tracer_bullet.gd'):
			obj.queue_free()
	elif obj extends preload('res://area_effects/area_effect.gd'):
		pass

func think(dt, player):
	pass
