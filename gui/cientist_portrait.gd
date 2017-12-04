extends Node2D

onready var idle = get_node("Idle_Sprite")
onready var talking = get_node("Talking_Sprite")

func _ready():
	idle.show()
	talking.hide()

func start_talking():
	idle.hide()
	talking.show()

func stop_talking():
	idle.show()
	talking.hide()