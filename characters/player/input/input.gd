extends Node

const DIR = preload('directions.gd')
const ACT = preload('actions.gd')

signal hold_direction(dir)
signal hold_action(act)
signal hold_look(dir)
signal press_direction(dir)
signal press_action(act)
signal press_quit


func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _input(event):
	var dir = self._get_direction(event)
	var act = self._get_action(event)
	if dir != -1: emit_signal('press_direction', dir)
	if act != -1: emit_signal('press_action', act)
	if _get_quit(event): emit_signal('press_quit')

func _fixed_process(delta):
	var dir = self._get_direction(Input)
	var act = self._get_action(Input)
	var look_dir = self._get_look_direction(Input)
	if dir != -1: emit_signal('hold_direction', dir)
	if act != -1: emit_signal('hold_action', act)
	if look_dir != -1: emit_signal('hold_look', look_dir)

func _get_quit(e):
	if e.is_action_pressed('ui_quit'):
		return true

func _get_action(e):
	var act = -1
	return act

func _get_look_direction(e):
	var dir = -1
	if e.is_action_pressed('look_up') and not e.is_action_pressed('look_down'):
		dir = DIR.UP
	elif e.is_action_pressed('look_down') and not e.is_action_pressed('look_up'):
		dir = DIR.DOWN
	if e.is_action_pressed('look_right') and not e.is_action_pressed('look_left'):
		dir = DIR.RIGHT
	elif e.is_action_pressed('look_left') and not e.is_action_pressed('look_right'):
		dir = DIR.LEFT
	if e.is_action_pressed('look_up') and e.is_action_pressed('look_right') \
		and not e.is_action_pressed('look_down') and not e.is_action_pressed('look_left'):
		dir = DIR.UP_RIGHT
	elif e.is_action_pressed('look_down') and e.is_action_pressed('look_left') \
		and not e.is_action_pressed('look_up') and not e.is_action_pressed('look_right'):
		dir = DIR.DOWN_LEFT
	if e.is_action_pressed('look_down') and e.is_action_pressed('look_right') \
		and not e.is_action_pressed('look_up') and not e.is_action_pressed('look_left'):
		dir = DIR.DOWN_RIGHT
	elif e.is_action_pressed('look_up') and e.is_action_pressed('look_left') \
		and not e.is_action_pressed('look_down') and not e.is_action_pressed('look_right'):
		dir = DIR.UP_LEFT
	return dir

func _get_direction(e):
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
