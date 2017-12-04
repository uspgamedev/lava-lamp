extends 'res://area_effects/area_effect.gd'

onready var timer = get_node('Timer')
onready var hit_timer = get_node('HitTimer')
onready var pl = get_node('../Player')
onready var input = get_node('/root/input')
onready var sprite = get_node('Sprite')
onready var area = get_node('Area2D')
onready var sfx = get_node('SFX')

signal finish

var enemyList = []
var hold_key
var angle = 0

func _ready():
	damage = 1
	timer.connect('timeout', self, '_finish')
	timer.start()
	self.sfx.play('Burn')
	self.sprite.set_emitting(true)
	set_fixed_process(true)
	set_process_unhandled_key_input(true)
	self._set_rot(self.angle)

func _set_rot(angle):
	sprite.set_rot(angle)
	area.set_rot(angle)

func _unhandled_key_input(ev):
	if ev.scancode == hold_key and not ev.pressed:
		_finish()

func _fixed_process(delta):
	self.set_pos(pl.get_pos() + 20*pl.get_look_vec())
	self._set_rot(pl.get_look_dir().angle())

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

