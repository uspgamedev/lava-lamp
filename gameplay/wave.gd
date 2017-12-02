extends Node

signal ended
var main
var enemy_count = 10

var Enemy = preload('res://characters/enemies/enemy.tscn')

func create_enemy():
	var e = Enemy.instance()
	e.set_pos(Vector2(rand_range(0, 1280), 0))
	main.add_child(e)
	if enemy_count > 0:
		get_node('EnemyTimer').set_wait_time(rand_range(1, 3))
		get_node('EnemyTimer').start()

func start():
	main = get_parent().get_parent()
	var t = Timer.new()
	t.set_wait_time(rand_range(1, 3))
	t.start()
	t.set_name('EnemyTimer')
	t.connect('timeout', self, 'create_enemy')
	t.set_one_shot(true)
	add_child(t)