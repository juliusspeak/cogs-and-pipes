extends Node

signal state_changed

var levelMapController: LevelMapController
var camera: Camera3D
var ui: Control
var current_state: STATE = STATE.MENU:
	set(val):
		current_state = val
		state_changed.emit(val)
enum STATE {MENU, LEVELSELECT, GAME}
