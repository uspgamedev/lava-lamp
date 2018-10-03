extends 'simple_bullet.gd'

onready var sfx = get_node('SFX')

func _ready():
	sfx.get_node('Buzzt').play()

func _on_Area2D_area_entered(area):
	if damages_player and area.get_parent().get_name() == 'Player':
		area.get_parent()._stun()
	._on_Area2D_area_entered(area)
