extends Node

var move_cooldown_max = 1
var move_cooldown = 0

var sp = 5000

var lb = null;

func think(dt, enemy, player):
	if lb == null:
		lb = Label.new()
		get_node('/root/Main/Floor').get_parent().add_child(lb)
	move_cooldown -= dt
	if move_cooldown <= 0:
		var gmng = player.get_node('GridManager')
		var tm = get_node('/root/Main/Floor')
		var cood = tm.world_to_map(enemy.get_pos())
		
		print("enemy at ", cood, " dist ", gmng.dist[cood])
		if gmng.nxt.has(cood) and gmng.dist[cood] > 3:
			lb.set_text("AAA")
			lb.set_pos(tm.map_to_world(gmng.nxt[cood]))
			
			var vec = tm.map_to_world(gmng.nxt[cood]) - tm.map_to_world(cood)
			enemy.speed += (sp * dt * vec.normalized())
		else:
			var vec = player.get_pos() - enemy.get_pos()
			enemy.speed += (sp * dt * vec.normalized())

func collided_with_player(enemy, player):
	var vec = player.get_pos() - enemy.get_pos()
	player.speed += 5000 * vec.normalized()
	player.deal_damage(1)
	move_cooldown = move_cooldown_max
