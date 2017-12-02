extends 'res://characters/body_fixed_speed.gd'

onready var timer = get_node('Timer')
onready var sfx = get_node('SFX')
onready var main = get_node('../../')

func _ready():
	timer.connect('timeout', self, 'queue_free')
	timer.start()
	sfx.play("Shoot")
	set_fixed_process(true)

func _fixed_process(delta):
	if (!main.is_a_valid_position(self.get_pos())):
		self.queue_free()

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.damage += 1
		if (enemy.damage >= enemy.hp):
			enemy.queue_free()
		self.queue_free()
