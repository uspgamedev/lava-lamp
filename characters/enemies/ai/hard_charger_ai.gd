extends 'follow_player.gd'

var charge_cooldown = 0
var walk_cooldown = 0
var state = WALK

enum {
	WALK,
	LOAD_CHARGE,
	CHARGE
}

func _ready():
	sp = 4000

var charge_vec
var charge_left
var max_charge

func think(dt, player):
	var enemy = get_parent()
	if state == WALK:
		walk_cooldown -= dt
		var player_to_enemy_dist = enemy.get_position().distance_squared_to(player.get_position())
		var collided = enemy.test_move(Transform2D(enemy.get_rotation(), enemy.get_position()), player.get_position() - enemy.get_position())
		if walk_cooldown <= 0 and player_to_enemy_dist < 250 * 250 and not collided:
			charge_cooldown = 1
			state = LOAD_CHARGE
		else:
			.think(dt, player)
	elif state == LOAD_CHARGE:
		charge_cooldown -= dt
		if charge_cooldown <= 0:
			charge_vec = (player.get_position() - enemy.get_position()).normalized()
			state = CHARGE
			charge_cooldown = 1
			charge_left = 1
			max_charge = 3
	elif state == CHARGE:
		charge_cooldown -= dt
		max_charge -= dt
		if max_charge <= 0:
			state = WALK
			walk_cooldown = 5
		if charge_left > 0 and charge_cooldown <= 0:
			charge_cooldown = 1
			charge_vec = (player.get_position() - enemy.get_position()).normalized()
			charge_left -= 1
		enemy.speed += charge_vec * 20000 * dt
		var kinematic_collision = enemy.get_slide_collision(0)
		if kinematic_collision != null and kinematic_collision.collider is TileMap:
			collided_with_wall()

func collided_with_player(player):
	var enemy = get_parent()
	var vec = player.get_position() - enemy.get_position()
	if (player.shieldTime != 0):
		enemy.speed += knockback * vec.normalized()
	else:
		player.speed += ([4000, 500, 10000][state]) * vec.normalized()
		player.deal_damage([2, 1, 4][state])
		move_cooldown = move_cooldown_max
		player.dashTime = 0
		state = WALK
		walk_cooldown = 3

func hit(obj):
	if obj is preload('res://bullets/ion_bullet.gd') or \
	   obj is preload('res://bullets/shotgun_bullet.gd') or \
	   obj is preload('res://bullets/trap.gd') or \
	   obj is preload('res://area_effects/earthquake.gd'):
		state = WALK
		walk_cooldown = 2
	.hit(obj)

func collided_with_wall():
	var enemy = get_parent()
	if state == CHARGE:
		enemy.deal_damage(1)
	state = WALK
	walk_cooldown = 3
