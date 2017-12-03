extends 'res://bullets/bullet.gd'

onready var props = get_parent()
onready var timer = get_node('Timer')
onready var sfx = get_node('SFX')
onready var main = get_node('../../')
onready var guided_speed = Vector2(0, 0)
onready var enemy = null

signal enemy_dead

func _ready():
	timer.connect('timeout', self, 'queue_free')
	timer.start()
	sfx.play("Shoot")
	search_nearest_enemy()
	set_fixed_process(true)
	damage = 5

func _fixed_process(delta):
	update_speed()

func _update_enemy():
	enemy = null

func update_speed():
	if (enemy and enemy.get_ref()):
		guided_speed = (guided_speed.normalized() * .95 +  .05 * (enemy.get_ref().get_pos() - self.get_pos()).normalized()) * 300
	self.speed = guided_speed

func search_nearest_enemy():
	var min_distance = Vector2(10e+10, 10e+10)
	for i in props.get_children():
		if i.is_in_group('enemy'):
			var distance = i.get_pos() - self.get_pos()
			if min_distance.length() > distance.length():
				min_distance = distance
				enemy = i
				enemy.connect('enemy_dead', self, '_update_enemy')
	if enemy != null:
		enemy = weakref(enemy)
	var player = get_node('../Player')
	guided_speed = player.get_look_dir().normalized() * 300

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.ai.hit_by_bullet(enemy, self)