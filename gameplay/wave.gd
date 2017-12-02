extends Node

signal ended
var main

onready var manager = get_parent()

onready var Enemy = manager.ENEMIES[0]
onready var enemy_count = manager.cur_wave*5 + 1

func create_enemy():
	var e = Enemy.instance()
	e.set_pos(Vector2(rand_range(0, 1280), 0))
	main.get_node("Props").add_child(e)
	if (enemy_count > 0):
		get_node('EnemyTimer').set_wait_time(rand_range(1, 3))
		get_node('EnemyTimer').start()
		enemy_count -= 1

func start():
	main = get_parent().get_parent()
	var t = Timer.new()
	t.set_wait_time(rand_range(1, 3))
	t.start()
	t.set_name('EnemyTimer')
	t.connect('timeout', self, 'create_enemy')
	t.set_one_shot(true)
	add_child(t)