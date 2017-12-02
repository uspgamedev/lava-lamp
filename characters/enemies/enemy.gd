extends KinematicBody2D

var speed = 3
var player

func _ready():
	player = get_node("../Player")
	set_fixed_process(true)
	
func _fixed_process(delta):
	var vec = player.get_pos() - get_pos()
	move(speed*vec/vec.length())
