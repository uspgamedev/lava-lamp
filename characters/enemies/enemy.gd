extends 'res://characters/body.gd'

var s = 1

export(NodePath) var playerPath
var cd_timer
var player
var ai

func _ready():
	player = get_node('../Player')
	cd_timer = get_node("Cooldown")
	ai = get_node("Ai")
	set_fixed_process(true)

func _fixed_process(delta):
	ai.think(delta, self, player)

func _on_Area2D_area_enter( area ):
	if area.is_in_group("player_area"):
		ai.collided_with_player(self, player)
