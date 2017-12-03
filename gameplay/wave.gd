extends Node

signal ended
var main

onready var manager = get_parent()

onready var Enemy = manager.ENEMIES[3]
onready var enemy_count = manager.cur_wave*1 + 1

func _ready():
	main = get_parent().get_parent()
	set_fixed_process(true)

func create_enemy():
	var e = Enemy.instance()
	e.set_pos(main.get_valid_position())

	main.get_node("Props").add_child(e)
	if (enemy_count > 0):
		get_node('EnemyTimer').set_wait_time(rand_range(1, 3))
		get_node('EnemyTimer').start()
		enemy_count -= 1

func check_wave_end():
	for i in main.get_node('Props').get_children():
		if i.is_in_group('enemy'):
			return
	if enemy_count <= 0:
		manager.wave_ended()
		enemy_count = manager.cur_wave*1 + 1

func _fixed_process(delta):
	check_wave_end()

func start():
	var t = Timer.new()
	t.set_wait_time(rand_range(1, 3))
	t.start()
	t.set_name('EnemyTimer')
	t.connect('timeout', self, 'create_enemy')
	t.set_one_shot(true)
	add_child(t)
