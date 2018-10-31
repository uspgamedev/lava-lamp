extends "res://addons/gut/test.gd"

func assert_enemy_takes_damage(enemy_scn, bullet_scn, damage):
	var props = get_node('/root/Main/Props')
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
