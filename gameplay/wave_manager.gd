extends Node

const ENEMIES = [
	preload('res://characters/enemies/olhinho.tscn'),
	preload('res://characters/enemies/charger.tscn'),
	preload('res://characters/enemies/shielded.tscn'),
	preload('res://characters/enemies/mage.tscn'),
	preload('res://characters/enemies/bouncer.tscn'),
	preload('res://characters/enemies/ghost.tscn'),
	preload('res://characters/enemies/undead.tscn'),
	preload('res://characters/enemies/hard_mage.tscn'),
	preload('res://characters/enemies/hard_charger.tscn'),
	preload('res://characters/enemies/hard_shielded.tscn'),
]

const ENEMY_POINTS = [
	2, #olhinho
	5, #charger
	7, #shielded
	12, #mage
	15, #bouncer
	20, #ghost
	25, #undead
	40, #hard mage
	60, #hard charger
]

const NEW_ENEMY_TYPE = 3
const NEW_ENEMY_PROPORTION = 1/3

var cur_wave = 1
var enemy_types = 9 #default = 1
var wave_points = 1000 #default = 10

var t

signal change_emotion(emotion, time)

onready var portrait = get_node('/root/Main/GUI/Player_Portrait')

func update_enemy_types():
	if (cur_wave%NEW_ENEMY_TYPE == 0 and enemy_types < ENEMIES.size()):
		enemy_types += 1

func update_wave_points():
	wave_points += cur_wave*3
	print(cur_wave, ' wave points ', wave_points)

func wave_ended():
	print('Wave ', cur_wave, ' ended')
	emit_signal('change_emotion', "happy", 3)
	cur_wave += 1
	update_enemy_types()
	update_wave_points()
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
