extends Node2D

var cur = 0
onready var pg_bar = get_node("ProgressBar")
var icon

signal cooldown_end

func _ready():
	set_fixed_process(true)
	get_node("Sprite").set_texture(load(icon))

func set_max(mx):
	pg_bar.set_max(mx)
	cur = mx

func _fixed_process(dt):
	cur -= dt
	pg_bar.set_value(cur)
	if cur <= 0:
		get_parent().fix_y(self)
		queue_free()
		emit_signal('cooldown_end')
