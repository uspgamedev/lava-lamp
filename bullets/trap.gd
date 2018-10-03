extends 'res://bullets/bullet.gd'

const Explo = preload("res://bullets/trap/explo.tscn")
const Death = preload("res://effects/death.tscn")

onready var sfx = get_node("SFX")

func _ready():
	sfx.get_node('Place').play()
	damage = 5

func _exit_tree():
	var explo = Explo.instance()
	explo.set_position(self.get_position())
	var death = Death.instance()
	death.set_position(self.get_position())
	self.get_parent().add_child(explo)
	self.get_parent().add_child(death)


func _on_Area2D_area_entered(area):
	pass # replace with function body
