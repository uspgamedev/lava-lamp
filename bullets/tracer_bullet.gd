extends 'res://bullets/simple_bullet.gd'

onready var sfx = get_node("SFX")

var hitting = false

func _ready():
	self.set_collision_mask(2)
	self.sfx.play("Fly")

func _fixed_process(delta):
	if hitting:
		self.sfx.play("Hit")
		hitting = false
		for i in range(20):
			yield(get_tree(), "fixed_frame")
		self.sfx.play("Fly")

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		hitting = true
	._on_Area2D_area_enter(area)