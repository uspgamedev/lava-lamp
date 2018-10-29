extends Node2D

export(Texture) var full_heart
export(Texture) var empty_heart

var hp

func _ready():
	recreate(4)

func recreate(hp):
	self.hp = hp
	for c in get_children():
		c.free()
	for i in range(hp):
		var s = Sprite.new()
		s.set_position(Vector2(32 * i, 0))
		add_child(s)
	update()

func update():
	var pl = get_node('/root/TestCellar/Props/Player');
	for i in range(hp):
		if i < pl.hp - pl.damage:
			get_child(i).set_texture(full_heart)
		else:
			get_child(i).set_texture(empty_heart)
