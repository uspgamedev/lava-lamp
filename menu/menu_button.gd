extends Button

export(NodePath) var descriptor_path = null
export(String) var description

var descriptor

func _ready():
	if descriptor_path:
		descriptor = get_node(descriptor_path)


func _on_MenuButton_mouse_entered():
	if descriptor and descriptor.get("text"):
		descriptor.set_text(description)


func _on_MenuButton_mouse_exited():
	if descriptor and descriptor.get("text"):
		descriptor.set_text("")
