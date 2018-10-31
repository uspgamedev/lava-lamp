extends "res://addons/gut/test.gd"

func assert_enemy_takes_damage(enemy_scn, bullet_scn, hp, damage):
	var props = get_node('/root/Main/Props')
	var _enemy_scn = load(enemy_scn)
	var _bullet_scn = load(bullet_scn)
	var enemy = _enemy_scn.instance()
	var bullet = _bullet_scn.instance()
	props.add_child(enemy)
	props.add_child(bullet)
	assert_eq(enemy.hp, hp, 'should have 4 hp')
	bullet._on_Area2D_area_entered(enemy.get_node('Area2D'))
	assert_eq(enemy.damage, damage, 'should take 1 hp of damage')
	
func test_assert_eye_damage():
	assert_enemy_takes_damage("res://characters/enemies/olhinho.tscn", "res://bullets/simple_bullet.tscn", 4, 1)

func test_assert_shielded_damage():
	assert_enemy_takes_damage("res://characters/enemies/shielded.tscn", "res://bullets/simple_bullet.tscn", 4, 1)

func test_assert_chargerdamage():
	assert_enemy_takes_damage("res://characters/enemies/charger.tscn", "res://bullets/simple_bullet.tscn", 4, 1)
