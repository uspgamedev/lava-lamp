extends Sprite

onready var anim = get_node("AnimationPlayer")

var size

func charge_small():
	self.size = "small"
	self.anim.set_current_animation("small_charging")

func charge_medium():
	self.size = "medium"
	self.anim.set_current_animation("medium_charging")

func charge_large():
	self.size = "large"
	self.anim.set_current_animation("large_charging")

func stop_charge():
	self.anim.set_current_animation(self.size)
