extends "res://characters/enemies/enemy.gd"

onready var anim = get_node("Sprite/AnimationPlayer")

func _bounce():
	anim.set_current_animation("strike")
	yield(anim, "finished")
	anim.set_current_animation("move")
	anim.play()
