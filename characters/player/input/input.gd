extends Node

const DIR = preload('directions.gd')
const ACT = preload('actions.gd')

signal hold_direction(dir)
signal hold_action(act)
signal hold_look(dir)
signal press_direction(dir)
signal press_action(act)
signal not_hold_action
signal press_quit
signal skip_intro

var binds = []

enum {
	KEYBOARD,
	KEYBOARD2,
	MOUSE
}

var control_type
var shoot_on_click

var cur = 0
# Last time this direction was held
var last_dir_hold = []

func _ready():
	binds.resize(17)
	for i in range(4):
		last_dir_hold.append(-10)


func set_control_type(tp):
	if (!has_node('/root/Main/Map')):
		return
	var pl = get_node('/root/Main/Map/Props/Player')
	control_type = tp
	if tp == KEYBOARD:
		shoot_on_click = true
	elif tp == MOUSE or tp == KEYBOARD2:
		shoot_on_click = false
	if tp == MOUSE:
		pl.get_node('Hook/LookArrow').visible = false
	else:
		pl.get_node('Hook/LookArrow').visible = true

func get_key_string(key):
	if (!has_node('/root/Main/Map')):
		return
	if (key >= KEY_SPACE):
		return OS.get_scancode_string(key)
	if key == BUTTON_RIGHT: return 'Right Mouse Button'
	if key == BUTTON_MIDDLE: return 'Middle Mouse Button'
	if key == BUTTON_WHEEL_UP: return 'Mouse wheel up'
	if key == BUTTON_WHEEL_DOWN: return 'Mouse wheel down'
	if key == BUTTON_WHEEL_LEFT: return 'Mouse wheel left button'
	if key == BUTTON_WHEEL_RIGHT: return 'Mouse wheel right button'

func _input(event):
	if (!has_node('/root/Main')):
		return
	if get_tree().is_paused():
		if not get_node('/root/Main/GUI/GameOver').is_visible() and event.is_action_pressed('pause'):
			get_tree().set_pause(false)
			get_node('/root/Main/GUI/PauseScreen').visible = false
		return
	else:
		if event.is_action_pressed('pause'):
			get_tree().set_pause(true)
			get_node('/root/Main/GUI/MoveList').visible = false
			get_node('/root/Main/GUI/PauseNotice').hide()
			get_node('/root/Main/GUI/PauseScreen').visible = true
	if event.is_action_pressed('show_moves'):
		var ah = get_node('/root/Main/Map/Props/Player/ActionHandler')
		var mp = ah.action_map
		var txt = ""
		var keys = ah.get_keys_used()
		for i in range(keys.size()):
			txt += "%s:  %s\n" % [get_key_string(keys[i]), mp[keys[i]].get_name().replace("_", " ")]
		get_node('/root/Main/GUI/MoveList/Description').set_text(txt)
		get_node('/root/Main/GUI/MoveList').visible = true
	elif event.is_action_released('show_moves'):
		get_node('/root/Main/GUI/MoveList').visible = false
	var dir = self._get_direction(event)
	var act = self._get_action(event)
	if dir != -1: emit_signal('press_direction', dir)
	if act != -1: emit_signal('press_action', act)
	if _get_skip_intro(event): emit_signal('skip_intro')
	if _get_quit(event): emit_signal('press_quit')

func _physics_process(delta):
	if (!has_node('/root/Main')):
		return
	cur += delta
	var dir = self._get_direction(Input)
	var act = self._get_action(Input)
	var look_dir = self._get_look_direction(Input)
	if dir != -1: emit_signal('hold_direction', dir)
	if look_dir != -1: emit_signal('hold_look', look_dir)
	if act != -1: emit_signal('hold_action', act)
	else: emit_signal('not_hold_action')

func _get_quit(e):
	if e.is_action_pressed('ui_quit'):
		return true

func _get_skip_intro(e):
	if e.is_action_pressed('skip_intro'):
		return true

func _get_action(e):
	if control_type == MOUSE:
		if e.is_action_pressed('mouse_down'):
			return 1
		else:
			return -1
	elif control_type == KEYBOARD2:
		if e.is_action_pressed('keyboard2_click'):
			return 1
		else:
			return -1
	elif control_type == KEYBOARD:
		return -1
	else:
		breakpoint

func _get_look_direction(e):
	if control_type == KEYBOARD:
		if not Input.is_action_pressed("lock_dir"):
			return _get_direction(e)
		return -1
	elif control_type == MOUSE:
		var p = get_viewport().get_mouse_position()
		var pl_p = get_node('/root/Main/Map/Props/Player').get_global_transform_with_canvas().origin
		var ang = atan2(p.x - pl_p.x, p.y  - pl_p.y)
		if ang >= PI * 7.0 / 8 or ang <= -PI * 7.0 / 8:
			return DIR.UP
		var tp = floor((ang + PI * 7.0 / 8) / (PI / 4.0))
		return [DIR.UP_LEFT, DIR.LEFT, DIR.DOWN_LEFT, DIR.DOWN, DIR.DOWN_RIGHT, DIR.RIGHT, DIR.UP_RIGHT][min(6, tp)]
	elif control_type == KEYBOARD2:
		pass
	else:
		breakpoint
	var i = 0
	for cmd in ['look_up', 'look_down', 'look_right', 'look_left']:
		if e.is_action_pressed(cmd):
			last_dir_hold[i] = cur
		i += 1
	# Only considers a key is not pressed if it has not been pressed for threshold seconds
	var threshold = .1
	# alx = is actually pressing the direction x
	# lx = has pressed the direction x in the last threshold secs
	var alu = last_dir_hold[0] == cur
	var lu = last_dir_hold[0] >= cur - threshold
	var ald = last_dir_hold[1] == cur
	var ld = last_dir_hold[1] >= cur - threshold
	var alr = last_dir_hold[2] == cur
	var lr = last_dir_hold[2] >= cur - threshold
	var all = last_dir_hold[3] == cur
	var ll = last_dir_hold[3] >= cur - threshold
	var dir = -1
	if alu and not ld:
		dir = DIR.UP
	elif ald and not lu:
		dir = DIR.DOWN
	if alr and not ll:
		dir = DIR.RIGHT
	elif all and not lr:
		dir = DIR.LEFT
	if lu and lr \
		and not ld and not ll:
		dir = DIR.UP_RIGHT
	elif ld and ll \
		and not lu and not lr:
		dir = DIR.DOWN_LEFT
	if ld and lr \
		and not lu and not ll:
		dir = DIR.DOWN_RIGHT
	elif lu and ll \
		and not ld and not lr:
		dir = DIR.UP_LEFT
	return dir

func _get_direction(e):
	# Same for both control types
	var dir = -1
	if e.is_action_pressed('ui_up') and not e.is_action_pressed('ui_down'):
		dir = DIR.UP
	elif e.is_action_pressed('ui_down') and not e.is_action_pressed('ui_up'):
		dir = DIR.DOWN
	if e.is_action_pressed('ui_right') and not e.is_action_pressed('ui_left'):
		dir = DIR.RIGHT
	elif e.is_action_pressed('ui_left') and not e.is_action_pressed('ui_right'):
		dir = DIR.LEFT
	if e.is_action_pressed('ui_up') and e.is_action_pressed('ui_right') \
		and not e.is_action_pressed('ui_down') and not e.is_action_pressed('ui_left'):
		dir = DIR.UP_RIGHT
	elif e.is_action_pressed('ui_down') and e.is_action_pressed('ui_left') \
		and not e.is_action_pressed('ui_up') and not e.is_action_pressed('ui_right'):
		dir = DIR.DOWN_LEFT
	if e.is_action_pressed('ui_down') and e.is_action_pressed('ui_right') \
		and not e.is_action_pressed('ui_up') and not e.is_action_pressed('ui_left'):
		dir = DIR.DOWN_RIGHT
	elif e.is_action_pressed('ui_up') and e.is_action_pressed('ui_left') \
		and not e.is_action_pressed('ui_down') and not e.is_action_pressed('ui_right'):
		dir = DIR.UP_LEFT
	return dir
