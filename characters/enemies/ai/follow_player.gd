extends 'base_ai.gd'

var move_cooldown_max = 1
var move_cooldown = 0
var enemy
var sp = 5000
var goto_dir = null
var go_time = 0

func think(dt, player):
	var enemy = get_parent()
	var ep = enemy.get_position() - Vector2(0, 30)
	move_cooldown -= dt
	if move_cooldown <= 0:
		go_time -= dt
		if go_time > 0:
			enemy.speed += (sp * dt * goto_dir)
			return
		var gmng = player.get_node('GridManager')
		var tm = get_node('/root/Main/Map/Floor')
		var cood = tm.world_to_map(ep)

		if gmng.nxt.has(cood) and gmng.dist[cood] > 1:
			var to = tm.map_to_world(gmng.nxt[cood]) + tm.get_cell_size() / 2

			var vec = (to - ep).normalized()
			enemy.speed += (sp * dt * vec)
			goto_dir = vec
			go_time = .4
		else:
			var vec = player.get_position() - enemy.get_position()
			enemy.speed += (sp * dt * vec.normalized())

func collided_with_player(player):
	move_cooldown = move_cooldown_max
	.collided_with_player(player)
	