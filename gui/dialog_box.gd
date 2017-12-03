extends Node2D

onready var tb = get_node("Text Box BG")
func _ready():
	pass
	
func activate_box():
	tb.activate()
	
func deactivate_box():
	tb.deactivate()


