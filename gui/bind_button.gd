extends VBoxContainer


onready var input = get_node('/root/input')
onready var binds = input.binds
var reserved_keys = [ 
KEY_W, KEY_A, KEY_S, KEY_D, KEY_ESCAPE, KEY_TAB, KEY_LEFT, KEY_UP, KEY_RIGHT, \
KEY_DOWN, BUTTON_LEFT, KEY_ALT, KEY_SUPER_L
]
var key = KEY_0
var waiting_key = false
var selected_button
var old_text

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
	if waiting_key:
		if (ev is InputEventMouseButton):
			key = ev.button_index
		elif (ev is InputEventKey):
			key = ev.scancode
		else:
			return
		if key == KEY_ESCAPE:
			get_node(selected_button).text = old_text
			waiting_key = false
			return
		for i in reserved_keys:
			if key == i:
				return
		for i in binds:
			if key == i:
				return
		waiting_key = false

func bind():
	waiting_key = true
	old_text = get_node(selected_button).text
	get_node(selected_button).text = "Choose Key"
	for button in get_children():
		button.disabled = true
	while(waiting_key):
		yield(get_tree(), 'physics_frame')
	if key != KEY_ESCAPE:
		match selected_button:
			"SimpleBullet":
				get_node(selected_button).text = get_key_string(key)
				binds[0] = key
			"Trap":
				get_node(selected_button).text = get_key_string(key)
				binds[1] = key
			"TracerBullet":
				get_node(selected_button).text = get_key_string(key)
				binds[2] = key
			"Dash":
				get_node(selected_button).text = get_key_string(key)
				binds[3] = key
			"GhostBullet":
				get_node(selected_button).text = get_key_string(key)
				binds[4] = key
			"Wormhole":
				get_node(selected_button).text = get_key_string(key)
				binds[5] = key
			"Armor":
				get_node(selected_button).text = get_key_string(key)
				binds[6] = key
			"IonBullet":
				get_node(selected_button).text = get_key_string(key)
				binds[7] = key
			"CureBullet":
				get_node(selected_button).text = get_key_string(key)
				binds[8] = key
			"GuidedBullet":
				get_node(selected_button).text = get_key_string(key)
				binds[9] = key
			"Shotgun":
				get_node(selected_button).text = get_key_string(key)
				binds[10] = key
			"RicochetBullet":
				get_node(selected_button).text = get_key_string(key)
				binds[11] = key
			"Storm":
				get_node(selected_button).text = get_key_string(key)
				binds[12] = key
			"ChargeBullet":
				get_node(selected_button).text = get_key_string(key)
				binds[13] = key
			"Laser":
				get_node(selected_button).text = get_key_string(key)
				binds[14] = key
			"Flamethrower":
				get_node(selected_button).text = get_key_string(key)
				binds[15] = key
			"DoubleBullet":
				get_node(selected_button).text = get_key_string(key)
				binds[16] = key
			
	for button in get_children():
		button.disabled = false

func _on_SimpleBullet_pressed():
	selected_button = "SimpleBullet"
	bind()


func _on_Trap_pressed():
	selected_button = "Trap"
	bind()


func _on_TracerBullet_pressed():
	selected_button = "TracerBullet"
	bind()


func _on_Dash_pressed():
	selected_button = "Dash"
	bind()


func _on_Wormhole_pressed():
	selected_button = "Wormhole"
	bind()


func _on_GhostBullet_pressed():
	selected_button = "GhostBullet"
	bind()


func _on_Armor_pressed():
	selected_button = "Armor"
	bind()


func _on_IonBullet_pressed():
	selected_button = "IonBullet"
	bind()


func _on_CureBullet_pressed():
	selected_button = "CureBullet"
	bind()


func _on_GuidedBullet_pressed():
	selected_button = "GuidedBullet"
	bind()


func _on_Shotgun_pressed():
	selected_button = "Shotgun"
	bind()


func _on_RicochetBullet_pressed():
	selected_button = "RicochetBullet"
	bind()


func _on_Storm_pressed():
	selected_button = "Storm"
	bind()


func _on_ChargeBullet_pressed():
	selected_button = "ChargeBullet"
	bind()


func _on_Laser_pressed():
	selected_button = "Laser"
	bind()


func _on_Flamethrower_pressed():
	selected_button = "Flamethrower"
	bind()


func _on_DoubleBullet_pressed():
	selected_button = "DoubleBullet"
	bind()
