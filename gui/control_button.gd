extends OptionButton

func _ready():
	add_item("Shoot - Arrows", 0)
	add_item("Shoot - Mouse", 1)
	select(1)

onready var input = get_node('/root/input')

func _on_OptionButton_item_selected( id ):
	if id == 0:
		input.set_control_type(input.KEYBOARD2)
	elif id == 1:
		input.set_control_type(input.MOUSE)
