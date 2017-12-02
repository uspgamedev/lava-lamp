extends 'res://characters/body.gd'

export (Vector2) var min_spawn_range
export (Vector2) var max_spawn_range

var player
var ai

signal enemy_dead

func _ready():

	player = get_node("../Player")
	ai = get_node("Ai")
	set_fixed_process(true)

func _fixed_process(delta):
	ai.think(delta, self, player)
	
#Return aproximate direction (only 4 cardinal directions) enemy is moving at
func get_look_dir_value():
	var temp = Vector2(get_speed().x, get_speed().y)
	temp.normalized()
	var abs_x = abs(temp.x)
	var abs_y = abs(temp.y)
	if abs_x > abs_y:
		if temp.x > 0:
			return DIR.RIGHT
		else:
			return DIR.LEFT
	else:
		if temp.y > 0:
			return DIR.DOWN
		else:
			return DIR.UP

func _on_Area2D_area_enter( area ):
	if area.is_in_group("player_area"):
		ai.collided_with_player(self, player)

func _queue_free():
	emit_signal('enemy_dead')
	self.queue_free()
