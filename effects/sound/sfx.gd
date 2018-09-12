extends AudioStreamPlayer2D

const SAMPLE = preload("res://effects/sound/sample.gd")

#export var autoplay = false
export(String) var which = ""

func _ready():
	for sample_node in self.get_children():
		if sample_node.get_script() == SAMPLE:
			get_sample_library().add_sample(sample_node.get_name(), sample_node.sample)
	if self.autoplay:
		play(self.which)
