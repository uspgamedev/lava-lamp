extends Node

onready var action = get_node("Action")
onready var interlude = get_node("Interlude")
onready var base = get_node("Base")

func _action_mode():
	action.set_volume(1)
	interlude.set_volume(0)

func _interlude_mode():
	action.set_volume(0)
	interlude.set_volume(1)

func stop():
	action.stop()
	interlude.stop()
	base.stop()

func play():
	action.play()
	interlude.play()
	base.play()