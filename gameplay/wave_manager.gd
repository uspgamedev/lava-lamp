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

onready var gui = get_node('/root/Main/GUI')
onready var portrait = gui.get_node('Player_Portrait')
onready var dialog_box = gui.get_node('Dialog Box')

func wave_ended():
	print('Wave ', cur_wave, ' ended')
	emit_signal('change_emotion', "happy", 3)
	cur_wave += 1
	t.start()

func new_wave():
	print('Wave ', cur_wave, ' started')
	var w = get_node('Wave')
	w.start()
	dialog_box.display_text("New wave incoming baby", 3)
	w.connect('ended', self, 'wave_ended')

func _ready():
	self.connect('change_emotion', portrait, 'change_emotion')
	t = Timer.new()
	t.set_wait_time(2)
	t.connect('timeout', self, 'new_wave')
	t.set_one_shot(true)
	t.start()
	add_child(t)
