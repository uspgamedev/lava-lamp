extends 'res://bullets/bullet.gd'

onready var props = get_parent()
onready var timer = get_node('Timer')
onready var main = get_node('../../')
onready var sfx = get_node('SFX')
onready var guided_speed = Vector2(0, 0)
onready var enemy = null

func _ready():
	timer.connect('timeout', self, 'queue_free')
	timer.start()
	self.sfx.play('Fly')
	search_nearest_enemy()

func _physics_process(delta):
	update_speed_scale()

func _update_enemy():
	enemy = null

func update_speed_scale():
	if (enemy and enemy.get_ref()):
		guided_speed = (guided_speed.normalized() * .95 +  .05 * (enemy.get_ref().get_position() - self.get_position()).normalized()) * 300
	self.speed = guided_speed

func search_nearest_enemy():
	var min_distance = Vector2(10e+10, 10e+10)
	for i in props.get_children():
		if i.is_in_group('enemy'):
			var distance = i.get_position() - self.get_position()
			if min_distance.length() > distance.length():
				min_distance = distance
				enemy = i
				enemy.connect('enemy_dead', self, '_update_enemy')
	if enemy != null:
		enemy = weakref(enemy)
	var player = get_node('../Player')
	guided_speed = player.get_look_dir().normalized() * 300
