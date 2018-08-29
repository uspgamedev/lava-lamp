extends Spatial

func set_texture(sp):
	var vp = get_node("Viewport")
	sp.position = Vector2(32, 32)
	#sp.set_scale(sp.get_scale() * Vector2(.5, .5))
	vp.add_child(sp)
	var txt = vp.get_texture()
	for spp in ['Sprite3D', 'Sprite3D1']:
		var s = get_node(spp)
		s.texture = txt

func _ready():
	#set_texture(preload('res://effects/fire/icon.tscn').instance())
	#set_texture(preload('res://bullets/charge_bullet/charge_bullet_sprite.tscn').instance())
	#set_texture(preload('res://scenario/props/wormhole/wormhole_sprite.tscn').instance())
	pass

func _physics_process(delta):
	var s = get_node('Sprite3D')
	s.translate(Vector3(0, 0, -0.025))
	s.rotate_y(delta * 2)
	s.translate(Vector3(0, 0, 0.025))
	s = get_node('Sprite3D1')
	s.translate(Vector3(0, 0, 0.025))
	s.rotate_y(delta * 2)
	s.translate(Vector3(0, 0, -0.025))
	get_node('MeshInstance').set_rotation(s.get_rotation())
