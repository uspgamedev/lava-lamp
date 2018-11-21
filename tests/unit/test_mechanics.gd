extends "res://addons/gut/test.gd"

func assert_enemy_takes_damage(enemy_scn, bullet_scn, damage):
	var props = get_node('/root/Main/Map/Props')
	var _enemy_scn = load(enemy_scn)
	var _bullet_scn = load(bullet_scn)
	var enemy = _enemy_scn.instance()
	var bullet = _bullet_scn.instance()
	props.add_child(enemy)
	props.add_child(bullet)
	bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	assert_eq(enemy.damage, damage, str('should take ', damage, ' hp of damage'))

func test_assert_trap_damage():
	assert_enemy_takes_damage("res://characters/enemies/shielded.tscn", "res://bullets/trap.tscn", 5)

func test_assert_tracer_damage():
	assert_enemy_takes_damage("res://characters/enemies/olhinho.tscn", "res://bullets/tracer_bullet.tscn", 2)

func test_assert_ghost_damage():
	assert_enemy_takes_damage("res://characters/enemies/ghost.tscn", "res://bullets/ghost_bullet.tscn", 1)

func test_assert_armor_damage_simple_enemy():
	var props = get_node('/root/Main/Map/Props')
	var player = props.get_node('Player')
	var _enemy_scn = load("res://characters/enemies/olhinho.tscn")
	var enemy = _enemy_scn.instance()
	props.add_child(enemy)
	player.shield(7)
	enemy.get_node('Ai').collided_with_player(player)
	assert_eq(enemy.damage, 1, str('should take ', 1, ' hp of damage'))

# não estamos zerando o damage antes dos testes
# testes q não funcionam: enemy_deals_damage, mage_bullet, sei lá

#func test_assert_armor_not_damaging_ghost():
#	var props = get_node('/root/Main/Map/Props')
#	var player = props.get_node('Player')
#	var _enemy_scn = load("res://characters/enemies/ghost.tscn")
#	var enemy = _enemy_scn.instance()
#	props.add_child(enemy)
#	enemy.get_node('Ai').collided_with_player(player)
#	assert_eq(enemy.damage, 0, str('should take ', 0, ' hp of damage'))

func test_assert_ion_stuns():
	var props = get_node('/root/Main/Map/Props')
	var _enemy_scn = load("res://characters/enemies/olhinho.tscn")
	var _bullet_scn = load("res://bullets/ion_bullet.tscn")
	var enemy = _enemy_scn.instance()
	var bullet = _bullet_scn.instance()
	props.add_child(enemy)
	props.add_child(bullet)
	bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	assert_ne(enemy.stunned, 0, str('should be stunned'))

# cure bullet já foi testada em test_enemy

func test_assert_guided_damage():
	assert_enemy_takes_damage("res://characters/enemies/olhinho.tscn", "res://bullets/guided_bullet.tscn", 2)

func test_assert_shotgun_damage():
	assert_enemy_takes_damage("res://characters/enemies/olhinho.tscn", "res://bullets/shotgun_bullet.tscn", 1)

func test_assert_ricochet_damage():
	assert_enemy_takes_damage("res://characters/enemies/olhinho.tscn", "res://bullets/ricochet_bullet.tscn", 1)

func test_assert_storm_damage():
	assert_enemy_takes_damage("res://characters/enemies/olhinho.tscn", "res://area_effects/earthquake.tscn", 4)

func assert_charge_damage(time, damage):
	var props = get_node('/root/Main/Map/Props')
	var _enemy_scn = load("res://characters/enemies/olhinho.tscn")
	var _bullet_scn = load("res://bullets/charge_bullet.tscn")
	var enemy = _enemy_scn.instance()
	var bullet = _bullet_scn.instance()
	var timer = Timer.new()
	timer.wait_time	 = time
	props.add_child(timer)
	props.add_child(enemy)
	props.add_child(bullet)
	bullet.charge_timer.wait_time = 1.0
	yield(timer, 'timeout')
	bullet._shoot()
	bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	assert_eq(enemy.damage, damage, str('should take ', damage, ' hp of damage'))

func test_assert_small_charge_damage():
	assert_charge_damage(.1, 1)

func test_assert_medium_charge_damage():
	assert_charge_damage(.5, 2)

func test_assert_large_charge_damage():
	assert_charge_damage(.9, 3)

func test_assert_laser_damage():
	var props = get_node('/root/Main/Map/Props')
	var _enemy_scn = load("res://characters/enemies/olhinho.tscn")
	var _bullet_scn = load("res://area_effects/laser.tscn")
	var enemy = _enemy_scn.instance()
	var bullet = _bullet_scn.instance()
	props.add_child(enemy)
	props.add_child(bullet)
	bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	bullet.player = props.get_node('Player')
	assert_eq(enemy.damage, .5, str('should take ', .5, ' hp of damage'))

func test_assert_flamethrower_damage():
	var props = get_node('/root/Main/Map/Props')
	var _enemy_scn = load("res://characters/enemies/olhinho.tscn")
	var _bullet_scn = load("res://area_effects/flamethrower.tscn")
	var enemy = _enemy_scn.instance()
	var bullet = _bullet_scn.instance()
	props.add_child(enemy)
	props.add_child(bullet)
	bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	bullet._hit()
	assert_eq(enemy.damage, 1, str('should take ', 1, ' hp of damage'))
	bullet._on_Area2D_area_exited(enemy.get_node('Area2D'))
