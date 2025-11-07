extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("rmb"):
		Builder.current_building = 0
	
	if event.is_action_pressed("lmb"):
		Builder.build()
	
	if event.is_action_pressed("esc"):
		if GlobalData.current_state == GlobalData.STATE.LEVELSELECT:
			GlobalData.current_state = GlobalData.STATE.MENU
		if GlobalData.current_state == GlobalData.STATE.MENU:
			return
			
		if GlobalData.current_state == GlobalData.STATE.GAME or GlobalData.current_state == GlobalData.STATE.EDITOR:
			print(GlobalData.current_state)
			GlobalData.current_state = GlobalData.STATE.PAUSE
			print(GlobalData.current_state)
		elif GlobalData.current_state == GlobalData.STATE.PAUSE:
			if GlobalData.prev_state == GlobalData.STATE.EDITOR or GlobalData.prev_state == GlobalData.STATE.GAME:
				GlobalData.current_state = GlobalData.prev_state
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			Builder.rotate_build(90)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			Builder.rotate_build(-90)
