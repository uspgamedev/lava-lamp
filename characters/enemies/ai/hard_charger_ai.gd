extends 'follow_player.gd'

var charge_cooldown = 0
var walk_cooldown = 0

enum {
	WALK,
	LOAD_CHARGE,
	CHARGE
}

var state = WALK

func _ready():
	sp = 4000

var charge_vec
var charge_left
var max_charge

func think(dt, player):
	var enemy = get_parent()
	if state == WALK:
		walk_cooldown -= dt
		if walk_cooldown <= 0 and enemy.get_pos().distance_squared_to(player.get_pos()) < 250 * 250 and not enemy.test_move(player.get_pos() - enemy.get_pos()):
			charge_cooldown = 1
			state = LOAD_CHARGE
		else:
			.think(dt, player)
	elif state == LOAD_CHARGE:
		charge_cooldown -= dt
		if charge_cooldown <= 0:
			charge_vec = (player.get_pos() - enemy.get_pos()).normalized()
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
			charge_vec = (player.get_pos() - enemy.get_pos()).normalized()
			charge_left -= 1
		enemy.speed += charge_vec * 20000 * dt
		if enemy.is_colliding():
			collided_with_wall()

func collided_with_player(player):
	var enemy = get_parent()
	var vec = player.get_pos() - enemy.get_pos()
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
	if obj extends preload('res://bullets/ion_bullet.gd') or \
	   obj extends preload('res://bullets/shotgun_bullet.gd') or \
	   obj extends preload('res://bullets/trap.gd') or \
	   obj extends preload('res://area_effects/earthquake.gd'):
		state = WALK
		walk_cooldown = 2
	.hit(obj)

func collided_with_wall():
	var enemy = get_parent()
	if state == CHARGE:
		enemy.deal_damage(1)
	state = WALK
	walk_cooldown = 3