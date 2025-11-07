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
		
		if GlobalData.paused == false:
			GlobalData.ui.show_menu()
			GlobalData.paused = true
		else:
			GlobalData.ui.hide_menu()
			GlobalData.paused = false
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			Builder.rotate_build(90)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			Builder.rotate_build(-90)
