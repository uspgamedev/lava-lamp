extends Node

onready var action = get_node("Action")
onready var interlude = get_node("Interlude")
onready var base = get_node("Base")
onready var tween1 = get_node('Tween1')
onready var tween2 = get_node('Tween2')

onready var opening = get_node("Opening")

func _ready():
	play()
	var t = Timer.new()
	t.wait_time = opening.stream.get_length()
	t.start()
	self.add_child(t)
	t.connect('timeout', self, '_action_mode')

func _action_mode():
	if !action.is_playing():
		opening.stop()
		action.play()
		interlude.play()
		base.play()
	tween1.interpolate_method(interlude, 'set_volume_db', interlude.get_volume_db(), 0, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween2.interpolate_method(action, 'set_volume_db', action.get_volume_db(), 1, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween1.start()
	tween2.start()

func _interlude_mode():
	tween1.interpolate_method(action, 'set_volume_db', action.get_volume_db(), 0, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween2.interpolate_method(interlude, 'set_volume_db', interlude.get_volume_db(), 1, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween1.start()
	tween2.start()

func stop():
	action.stop()
	interlude.stop()
	base.stop()

func play():
	opening.play()
