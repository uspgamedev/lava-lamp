extends Node

var move_cooldown_max = 1
var move_cooldown = 0

var sp = 5000

func think(dt, enemy, player):
	move_cooldown -= dt
	if move_cooldown <= 0:
		var gmng = player.get_node('GridManager')
		var tm = get_node('/root/Main/Floor')
		var cood = tm.world_to_map(enemy.get_pos())
		
		#print("enemy at", cood, "dist", gmng.dist[cood])
		if gmng.nxt.has(cood):
			var vec = tm.map_to_world(gmng.nxt[cood]) - enemy.get_pos()
			enemy.speed = (sp * dt * vec.normalized())
		else:
			return
			var vec = player.get_pos() - enemy.get_pos()
			enemy.speed += (sp * dt * vec.normalized())

func collided_with_player(enemy, player):
	var vec = player.get_pos() - enemy.get_pos()
	player.speed += 5000 * vec.normalized()
	player.deal_damage(1)
	move_cooldown = move_cooldown_max
