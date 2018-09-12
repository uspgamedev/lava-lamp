extends Sprite

export var is_head = false
onready var anim = get_node("AnimationPlayer")
onready var area = get_node("Area2D")

func _physics_process(delta):
	if self.is_head and self.anim.get_current_animation() != "head":
		self.anim.set_current_animation("head")
