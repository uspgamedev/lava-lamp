extends Node

onready var action = get_node("Action")
onready var interlude = get_node("Interlude")

func _action_mode():
	action.set_volume(1)
	interlude.set_volume(0)

func _interlude_mode():
	action.set_volume(0)
	interlude.set_volume(1)