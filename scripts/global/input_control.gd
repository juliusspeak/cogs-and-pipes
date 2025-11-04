extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("rmb"):
		Builder.current_building = 0
	
	if event.is_action_pressed("lmb"):
		Builder.build()
