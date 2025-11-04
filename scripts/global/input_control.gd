extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("rmb"):
		Builder.current_building = 0
	
	if event.is_action_pressed("lmb"):
		Builder.build()
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			Builder.rotate_build(90)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			Builder.rotate_build(-90)
