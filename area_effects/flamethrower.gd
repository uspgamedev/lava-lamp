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
var pressed = 0
var angle = 0

func _ready():
	damage = 1
	timer.connect('timeout', self, '_finish')
	timer.start()
	self.sfx.get_node('Burn').play()
	self.sprite.set_emitting(true)
	self._set_rotation(self.angle)

func _set_rotation(angle):
	sprite.set_rotation(angle)
	area.set_rotation(angle)

func _unhandled_input(ev):
	if ev.is_action_released("keyboard2_click"):
		pressed -= 1
	elif ev.is_action_pressed("keyboard2_click"):
		pressed += 1
	if input.control_type == input.KEYBOARD2 and ev is InputEventKey and \
		pressed == 0:
		_finish()
	elif input.control_type == input.MOUSE and ev is InputEventMouseButton and \
		 ev.button_index == BUTTON_LEFT and not ev.pressed:
		_finish()

func _physics_process(delta):
	self.set_position(pl.get_position() + 20*pl.get_look_vec())
	self._set_rotation(pl.get_look_dir().angle())

func _finish():
	set_process_unhandled_key_input(false)
	emit_signal('finish')
	self.queue_free()

func _on_Area2D_area_entered(area):
	if area.is_in_group('enemy_area'):
		enemyList.push_back(area.get_parent())

func _on_Area2D_area_exited(area):
	var targEnemy = area.get_parent()
	var cp = Array(enemyList)
	for i in range(cp.size()-1, -1, -1):
		if cp[i] == targEnemy:
			cp.remove(i)
	enemyList = cp

func _hit():
	for enemy in enemyList:
		enemy.ai.hit(self)
