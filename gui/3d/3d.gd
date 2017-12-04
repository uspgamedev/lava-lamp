extends Spatial

func set_texture(sp):
	for spp in ['Sprite3D', 'Sprite3D1']:
		var s = get_node(spp)
		s.set_texture(sp.get_texture())
		s.set_vframes(sp.get_vframes())
		s.set_hframes(sp.get_hframes())
		if sp.get_node('AnimationPlayer') != null:
			s.add_child(sp.get_node('AnimationPlayer').duplicate(true))

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var s = get_node('Sprite3D')
	s.translate(Vector3(0, 0, -0.025))
	s.rotate_y(delta * 2)
	s.translate(Vector3(0, 0, 0.025))
	s = get_node('Sprite3D1')
	s.translate(Vector3(0, 0, 0.025))
	s.rotate_y(delta * 2)
	s.translate(Vector3(0, 0, -0.025))
	get_node('TestCube').set_rotation(s.get_rotation())
