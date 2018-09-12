extends 'res://characters/body.gd'

const DEATH = preload("res://effects/death.tscn")

export (Vector2) var min_spawn_range
export (Vector2) var max_spawn_range

var player
var ai
var stunned = 0
var _last_dir = DIR.UP

signal enemy_dead
signal hit_taken

func _ready():
	player = get_node("../Player")
	ai = get_node("Ai")

func _physics_process(delta):
	stunned -= delta
	if stunned <= 0:
		ai.think(delta, player)

#Return aproximate direction (only 4 cardinal directions) enemy is moving at
func get_look_dir_value():
	if get_speed_scale().length_squared() <= 1:
		return _last_dir
	var x = atan2(get_speed_scale().x, get_speed_scale().y)
	if x > .75 * PI or x < -.75 * PI:
		_last_dir = DIR.UP
	else:
		_last_dir = [DIR.LEFT, DIR.DOWN, DIR.RIGHT][min(2, floor((x + .75 * PI) / (PI / 2.0)))]
	return _last_dir

func _on_Area2D_area_enter( area ):
	if area.is_in_group("player_area"):
		ai.collided_with_player(player)

func deal_damage(d):
	self.damage = max(0, self.damage + d)
	self.get_node("Sprite/Hit").play("hit")
	emit_signal("hit_taken")
	if self.damage >= self.hp:
		self._queue_free()
	get_node('EnemyHealth').update()

func _queue_free():
	emit_signal('enemy_dead')
	var death = DEATH.instance()
	death.set_position(self.get_position())
	self.get_parent().add_child(death)
	self.queue_free()
