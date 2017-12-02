extends Node

var cur_wave = 1

func wave_ended():
	print('Wave ', cur_wave, ' ended')
	cur_wave += 1

func new_wave():
	print('Wave ', cur_wave, ' started')
	var w = get_node('Wave')
	w.start()
	w.connect('ended', self, 'wave_ended')

func _ready():
	var t = Timer.new()
	t.set_wait_time(2)
	t.connect('timeout', self, 'wave')
	t.set_one_shot(true)
	t.start()
	add_child(t)
