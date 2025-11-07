extends Node

signal state_changed

var levelMapController: LevelMapController
var camera: Camera3D
var ui: Control
var paused: bool
var prev_state: STATE
var current_state: STATE = STATE.MENU:
	set(val):
		prev_state = current_state
		current_state = val
		if val == GlobalData.STATE.GAME or val == GlobalData.STATE.EDITOR:
			paused = false
		state_changed.emit(val)
		
enum STATE {MENU, LEVELSELECT, GAME, EDITOR}
