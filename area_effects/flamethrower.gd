extends 'res://area_effects/area_effect.gd'

onready var timer = get_node('Timer')
onready var hit_timer = get_node('HitTimer')
onready var pl = get_node('../Player')
onready var input = get_node('/root/input')

signal finish

var enemyList = []
var hold_key

func _ready():
	damage = 1
	timer.connect('timeout', self, '_finish')
	timer.start()
	set_fixed_process(true)
	set_process_unhandled_key_input(true)

func _unhandled_key_input(ev):
	if ev.scancode == hold_key and not ev.pressed:
		_finish()

func _fixed_process(delta):
	self.set_pos(pl.get_pos() + Vector2(0, -20))
	self.set_rot(pl.get_look_dir().angle())

func _finish():
	set_process_unhandled_key_input(false)
	emit_signal('finish')
	self.queue_free()

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		enemyList.push_back(area.get_parent())

func _on_Area2D_area_exit(area):
	var targEnemy = area.get_parent()
	var cp = Array(enemyList)
	for i in range(cp.size()-1, -1, -1):
		if cp[i] == targEnemy:
			cp.remove(i)
	enemyList = cp

func _hit():
	for enemy in enemyList:
		enemy.ai.hit(self)

