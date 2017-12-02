extends Node

const ENEMIES = [
	preload('res://characters/enemies/enemy.tscn'),
	preload('res://characters/enemies/olhinho.tscn'),
]

var cur_wave = 1
var t

func wave_ended():
	print('Wave ', cur_wave, ' ended')
	cur_wave += 1
	t.start()

func new_wave():
	print('Wave ', cur_wave, ' started')
	var w = get_node('Wave')
	w.start()
	w.connect('ended', self, 'wave_ended')

func _ready():
	t = Timer.new()
	t.set_wait_time(2)
	t.connect('timeout', self, 'new_wave')
	t.set_one_shot(true)
	t.start()
	add_child(t)
