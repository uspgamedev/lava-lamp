extends Node

var move_cooldown_max = 1
var move_cooldown = 0

var sp = 5000

func think(dt, enemy, player):
	move_cooldown -= dt
	if move_cooldown <= 0:
		var gmng = player.get_node('GridManager')
		var tm = get_node('/root/Main/Floor')
		var ep = enemy.get_pos() - Vector2(0, 30)
		var cood = tm.world_to_map(ep)
		
		if gmng.nxt.has(cood) and gmng.dist[cood] > 1:
			var to = tm.map_to_world(gmng.nxt[cood]) + tm.get_cell_size() / 2
			
			var vec = (to - ep).normalized()
			enemy.speed += (sp * dt * vec)
		else:
			var vec = player.get_pos() - enemy.get_pos()
			enemy.speed += (sp * dt * vec.normalized())

func collided_with_player(enemy, player):
	var vec = player.get_pos() - enemy.get_pos()
	player.speed += 5000 * vec.normalized()
	player.deal_damage(1)
	move_cooldown = move_cooldown_max
	player.dashTime = 0

func hit_by_bullet(enemy, bullet):
	enemy.damage += bullet.damage
	if (enemy.damage >= enemy.hp):
		enemy.queue_free()
	if not bullet extends preload('res://bullets/tracer_bullet.gd'):
		bullet.queue_free()
