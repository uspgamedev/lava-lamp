extends 'res://characters/body.gd'

var player
var ai

func _ready():

	player = get_node("../Player")
	ai = get_node("Ai")
	set_fixed_process(true)

func _fixed_process(delta):
	ai.think(delta, self, player)

func _on_Area2D_area_enter( area ):
	if area.is_in_group("player_area"):
		ai.collided_with_player(self, player)
