extends Node2D

var cur = 0
onready var pg_bar = get_node("ProgressBar")
onready var icon_spot = get_node("IconSpot")
var icon
var correct_y = 0

signal cooldown_end

func _ready():
	set_physics_process(true)
	icon_spot.add_child(icon.instance())

func set_max(mx):
	pg_bar.set_max(mx)
	cur = mx

func _physics_process(dt):
	cur -= dt
	pg_bar.set_value(cur)
	if cur <= 0:
		queue_free()
		get_parent().fix_y()
		emit_signal('cooldown_end')

