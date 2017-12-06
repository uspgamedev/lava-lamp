extends 'res://bullets/bullet.gd'

const Explo = preload("res://bullets/trap/explo.tscn")
const Death = preload("res://effects/death.tscn")

onready var sfx = get_node("SFX")

func _ready():
	sfx.play('Place')
	damage = 5

func _exit_tree():
	var explo = Explo.instance()
	explo.set_pos(self.get_pos())
	var death = Death.instance()
	death.set_pos(self.get_pos())
	self.get_parent().add_child(explo)
	self.get_parent().add_child(death)
