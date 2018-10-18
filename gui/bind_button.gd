extends Button

var reserved_keys = [ 
KEY_W, KEY_A, KEY_S, KEY_D, KEY_ESCAPE, KEY_TAB, KEY_LEFT, KEY_UP, KEY_RIGHT, \
KEY_DOWN, BUTTON_LEFT, KEY_ALT, KEY_SUPER_L
]

var binds = [17]
var key = KEY_0
var waiting_key = false

func get_key_string(key):
	if (key >= KEY_SPACE):
		return OS.get_scancode_string(key)
	if key == BUTTON_RIGHT: return 'Right Mouse Button'
	if key == BUTTON_MIDDLE: return 'Middle Mouse Button'
	if key == BUTTON_WHEEL_UP: return 'Mouse wheel up'
	if key == BUTTON_WHEEL_DOWN: return 'Mouse wheel down'
	if key == BUTTON_WHEEL_LEFT: return 'Mouse wheel left button'
	if key == BUTTON_WHEEL_RIGHT: return 'Mouse wheel right button'

func _input(ev):
	if (ev is InputEventMouseButton):
		key = ev.button_index
	elif (ev is InputEventKey):
		key = ev.scancode
	else: return
	for i in reserved_keys:
		if key == i:
			return
	waiting_key = false

func _pressed():
	waiting_key = true
	self.text = "Choose Key"
	while(waiting_key):
		yield(get_tree(), 'physics_frame')
	match self.name:
		"SimpleBullet":
			self.text = get_key_string(key)
			binds[0] = key
		"Trap":
			self.text = get_key_string(key)
			binds[1] = key
		"TracerBullet":
			self.text = get_key_string(key)
			binds[2] = key
		"Dash":
			self.text = get_key_string(key)
			binds[3] = key
		"GhostBullet":
			self.text = get_key_string(key)
			binds[4] = key
		"Wormhole":
			self.text = get_key_string(key)
			binds[5] = key
		"Armor":
			self.text = get_key_string(key)
			binds[6] = key
		"IonBullet":
			self.text = get_key_string(key)
			binds[7] = key
		"CureBullet":
			self.text = get_key_string(key)
			binds[8] = key
		"GuidedBullet":
			self.text = get_key_string(key)
			binds[9] = key
		"Shotgun":
			self.text = get_key_string(key)
			binds[10] = key
		"RicochetBullet":
			self.text = get_key_string(key)
			binds[11] = key
		"Storm":
			self.text = get_key_string(key)
			binds[12] = key
		"ChargeBullet":
			self.text = get_key_string(key)
			binds[13] = key
		"Laser":
			self.text = get_key_string(key)
			binds[14] = key
		"Flamethrower":
			self.text = get_key_string(key)
			binds[15] = key
		"DoubleBullet":
			self.text = get_key_string(key)
			binds[16] = key