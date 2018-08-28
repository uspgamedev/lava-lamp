extends Node

onready var action = get_node("Action")
onready var interlude = get_node("Interlude")
onready var base = get_node("Base")
onready var tween1 = get_node('Tween1')
onready var tween2 = get_node('Tween2')

onready var opening = get_node("Opening")

func _action_mode():
	if !action.is_playing():
		opening.stop()
		action.play()
		interlude.play()
		base.play()
	tween1.interpolate_method(interlude, 'set_volume', interlude.get_volume(), 0, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween2.interpolate_method(action, 'set_volume', action.get_volume(), 1, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween1.start()
	tween2.start()

func _interlude_mode():
	tween1.interpolate_method(action, 'set_volume', action.get_volume(), 0, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween2.interpolate_method(interlude, 'set_volume', interlude.get_volume(), 1, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween1.start()
	tween2.start()

func stop():
	action.stop()
	interlude.stop()
	base.stop()

func play():
	opening.play()
