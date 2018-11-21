extends "res://addons/gut/test.gd"

onready var wavemanager = get_tree()

func test_new_mechanic():
	print (get_node('/root/main').get_children() )
#	wavemanager.give_new_mechanics()
	assert_eq(1,1)