extends "res://addons/gut/test.gd"

func assert_enemy_takes_damage(enemy_scn, bullet_scn, hp, damage):
	var props = get_node('/root/Main/Map/Props')
	var _enemy_scn = load(enemy_scn)
	var _bullet_scn = load(bullet_scn)
	var enemy = _enemy_scn.instance()
	var bullet = _bullet_scn.instance()
	props.add_child(enemy)
	props.add_child(bullet)
	assert_eq(enemy.hp, hp, str('should have ', hp, ' hp'))
	bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	assert_eq(enemy.damage, damage, str('should take ', damage, ' hp of damage'))

func test_assert_eye_damage():
	assert_enemy_takes_damage("res://characters/enemies/olhinho.tscn", "res://bullets/simple_bullet.tscn", 4, 1)

func test_assert_shielded_damage():
	assert_enemy_takes_damage("res://characters/enemies/shielded.tscn", "res://bullets/simple_bullet.tscn", 4, 1)

func test_assert_charger_damage():
	assert_enemy_takes_damage("res://characters/enemies/charger.tscn", "res://bullets/simple_bullet.tscn", 4, 1)

func test_assert_ghost_damage():
	assert_enemy_takes_damage("res://characters/enemies/ghost.tscn", "res://bullets/ghost_bullet.tscn", 3, 1)

func test_assert_ghost_ghosts():
	assert_enemy_takes_damage("res://characters/enemies/ghost.tscn", "res://bullets/simple_bullet.tscn", 3, 0)

func test_assert_mage_damage():
	assert_enemy_takes_damage("res://characters/enemies/mage.tscn", "res://bullets/simple_bullet.tscn", 3, 1)

func test_assert_bouncer_bounces():
	assert_enemy_takes_damage("res://characters/enemies/bouncer.tscn", "res://bullets/simple_bullet.tscn", 4, 0)

func test_assert_bouncer_damage():
	var props = get_node('/root/Main/Map/Props')
	var _enemy_scn = load("res://characters/enemies/bouncer.tscn")
	var _bullet_scn = load("res://bullets/ion_bullet.tscn")
	var enemy = _enemy_scn.instance()
	var bullet = _bullet_scn.instance()
	props.add_child(enemy)
	props.add_child(bullet)
	assert_eq(enemy.hp, 4, 'should have 4 hp')
	bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	var simple_bullet_scn = load("res://bullets/simple_bullet.tscn")
	var simple_bullet = simple_bullet_scn.instance()
	simple_bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	assert_eq(enemy.damage, 1, 'should take 1 hp of damage')

func test_assert_undead_is_dead():
	assert_enemy_takes_damage("res://characters/enemies/undead.tscn", "res://bullets/simple_bullet.tscn", 16, 0)

func test_assert_undead_damage():
	assert_enemy_takes_damage("res://characters/enemies/undead.tscn", "res://bullets/cure_bullet.tscn", 16, 1)

func test_assert_undead_recover_health():
	var props = get_node('/root/Main/Map/Props')
	var _enemy_scn = load("res://characters/enemies/undead.tscn")
	var _bullet_scn = load("res://bullets/cure_bullet.tscn")
	var enemy = _enemy_scn.instance()
	var bullet = _bullet_scn.instance()
	props.add_child(enemy)
	props.add_child(bullet)
	assert_eq(enemy.hp, 16, 'should have 16 hp')
	bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	var simple_bullet_scn = load("res://bullets/simple_bullet.tscn")
	var simple_bullet = simple_bullet_scn.instance()
	simple_bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	assert_eq(enemy.damage, 0, 'should recover 1 hp')

func test_assert_absorber_absorbs():
	assert_enemy_takes_damage("res://characters/enemies/absorber.tscn", "res://bullets/simple_bullet.tscn", 4, 0)

func test_assert_absorber_damage():
	var props = get_node('/root/Main/Map/Props')
	var _enemy_scn = load("res://characters/enemies/absorber.tscn")
	var _bullet_scn = load("res://bullets/ion_bullet.tscn")
	var enemy = _enemy_scn.instance()
	var bullet = _bullet_scn.instance()
	props.add_child(enemy)
	props.add_child(bullet)
	assert_eq(enemy.hp, 4, 'should have 4 hp')
	bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	var simple_bullet_scn = load("res://bullets/simple_bullet.tscn")
	var simple_bullet = simple_bullet_scn.instance()
	simple_bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	assert_eq(enemy.damage, 1, 'should take 1 hp of damage')

func test_assert_hard_bouncer_bounces():
	assert_enemy_takes_damage("res://characters/enemies/hard_bouncer.tscn", "res://bullets/simple_bullet.tscn", 10, 0)

func test_assert_hard_bouncer_damage():
	assert_enemy_takes_damage("res://characters/enemies/hard_bouncer.tscn", "res://area_effects/earthquake.tscn", 10, 4)

func test_assert_hard_mage_damage():
	assert_enemy_takes_damage("res://characters/enemies/hard_mage.tscn", "res://bullets/simple_bullet.tscn", 5, 1)

func test_assert_hard_charger_damage():
	assert_enemy_takes_damage("res://characters/enemies/hard_charger.tscn", "res://bullets/simple_bullet.tscn", 6, 1)

func test_assert_hard_shielded_damage():
	assert_enemy_takes_damage("res://characters/enemies/hard_shielded.tscn", "res://bullets/simple_bullet.tscn", 6, 1)

func test_assert_armor_protects():
	var props = get_node('/root/Main/Map/Props')
	var player = props.get_node('Player')
	var _enemy_scn = load("res://characters/enemies/olhinho.tscn")
	var enemy = _enemy_scn.instance()
	props.add_child(enemy)
	player.shield(7)
	enemy.get_node('Ai').collided_with_player(player)
	assert_eq(player.damage, 0, str('should take ', 0, ' hp of damage'))

func test_assert_enemy_deals_damage():
	var props = get_node('/root/Main/Map/Props')
	var player = props.get_node('Player')
	var _enemy_scn = load("res://characters/enemies/olhinho.tscn")
	var enemy = _enemy_scn.instance()
	props.add_child(enemy)
	player.shield(0)
	enemy.get_node('Ai').collided_with_player(player)
	assert_eq(player.damage, 1, str('should take ', 1, ' hp of damage'))

func test_assert_mage_bullet_damage():
	var props = get_node('/root/Main/Map/Props')
	var _bullet_scn = load("res://bullets/mage_bullet.tscn")
	var player = props.get_node('Player')
	var bullet = _bullet_scn.instance()
	props.add_child(bullet)
	bullet._on_Area2D_area_entered(player.get_node('Area2D'))
	assert_eq(player.damage, 1, str('should take ', 1, ' hp of damage'))

func test_assert_hard_bouncer_bounces_damage():
	var props = get_node('/root/Main/Map/Props')
	var _enemy_scn = load("res://characters/enemies/bouncer.tscn")
	var _bullet_scn = load("res://bullets/simple_bullet.tscn")
	var player = props.get_node('Player')
	var enemy = _enemy_scn.instance()
	var bullet = _bullet_scn.instance()
	props.add_child(enemy)
	props.add_child(bullet)
	bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	bullet._on_Area2D_area_entered(player.get_node('Area2D'))
	assert_eq(player.damage, 1, 'should take 1 hp of damage')
