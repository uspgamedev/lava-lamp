extends 'res://characters/body.gd'

var s = 1

export(NodePath) var playerPath
var cd_timer
var player

func _ready():
	player = get_node(playerPath)
	cd_timer = get_node("Cooldown")
	set_fixed_process(true)
	
func _fixed_process(delta):
	if cd_timer.get_time_left() == 0:
		var vec = player.get_pos() - get_pos()
		move(s * vec.normalized())

func _on_Area2D_area_enter( area ):
	if area.is_in_group("player_area"):
		var vec = player.get_pos() - get_pos()
		player.speed += 3000 * s * vec.normalized()
		player.deal_damage(1)
		cd_timer.start()