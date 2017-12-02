extends Node

func wave1_ended():
	print('Wave 1 ended')

func wave1():
	print('Wave 1 started')
	var w1 = get_node('Wave1')
	w1.start()
	w1.connect('ended', self, 'wave1_ended')

func _ready():
	var t = Timer.new()
	t.set_wait_time(2)
	t.connect('timeout', self, 'wave1')
	t.set_one_shot(true)
	t.start()
	add_child(t)
