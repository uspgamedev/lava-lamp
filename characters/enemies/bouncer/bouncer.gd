extends "res://characters/enemies/enemy.gd"

onready var anim = get_node("Sprite/AnimationPlayer")
onready var sfx = get_node('SFX')

func _bounce():
	sfx.play('Homerun')
	anim.set_current_animation("strike")
	yield(anim, "finished")
	anim.set_current_animation("move")
	anim.play()

