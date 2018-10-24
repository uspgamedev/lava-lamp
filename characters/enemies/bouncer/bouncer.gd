extends "res://characters/enemies/enemy.gd"

onready var anim = get_node("Sprite/AnimationPlayer")

func _bounce():
	get_node('Homerun').play()
	anim.set_current_animation("strike")
	yield(anim, "animation_finished")
	anim.set_current_animation("move")
	anim.play()
