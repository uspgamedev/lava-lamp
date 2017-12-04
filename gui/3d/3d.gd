extends Spatial

func set_texture(sp):
	var vp = get_node("Viewport")
	sp.set_pos(Vector2(32, 32))
	#sp.set_scale(sp.get_scale() * Vector2(.5, .5))
	vp.add_child(sp)
	var txt = vp.get_render_target_texture()
	for spp in ['Sprite3D', 'Sprite3D1']:
		var s = get_node(spp)
		s.set_texture(txt)

func _ready():
	set_fixed_process(true)
	#set_texture(preload('res://effects/fire/icon.tscn').instance())
	#set_texture(preload('res://bullets/charge_bullet/charge_bullet_sprite.tscn').instance())
	#set_texture(preload('res://scenario/props/wormhole/wormhole_sprite.tscn').instance())

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
