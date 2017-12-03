extends Node

const ENEMIES = [
	preload('res://characters/enemies/enemy.tscn'),
	preload('res://characters/enemies/olhinho.tscn'),
	preload('res://characters/enemies/shielded.tscn'),
	preload('res://characters/enemies/charger.tscn'),
	preload('res://characters/enemies/bouncer.tscn'),
]

var cur_wave = 1
var t

signal change_emotion(emotion, time)

onready var portrait = get_node('/root/Main/GUI/Player_Portrait')

func wave_ended():
	print('Wave ', cur_wave, ' ended')
	emit_signal('change_emotion', "happy", 3)
	cur_wave += 1
	t.start()

func new_wave():
	print('Wave ', cur_wave, ' started')
	var w = get_node('Wave')
	w.start()
	w.connect('ended', self, 'wave_ended')

func _ready():
	self.connect('change_emotion', portrait, 'change_emotion')
	t = Timer.new()
	t.set_wait_time(2)
	t.connect('timeout', self, 'new_wave')
	t.set_one_shot(true)
	t.start()
	add_child(t)
