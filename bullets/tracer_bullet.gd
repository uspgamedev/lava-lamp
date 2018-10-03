extends 'res://bullets/simple_bullet.gd'

onready var sfx = get_node("SFX")

var hitting = false

func _ready():
	self.set_collision_mask(2)
	self.sfx.get_node("Fly").play()

func _physics_process(delta):
	if hitting:
		self.sfx.get_node("Hit").play()
		hitting = false
		for i in range(20):
			yield(get_tree(), "physics_frame")
		self.sfx.get_node("Fly").play()

func _on_Area2D_area_entered(area):
	if area.is_in_group('enemy_area'):
		hitting = true
	._on_Area2D_area_entered(area)
