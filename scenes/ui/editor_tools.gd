extends VBoxContainer
@export var lock_button: Button


func _on_lock_button_pressed() -> void:
	match Builder.current_state:
		Builder.STATE.BUILDING:
			Builder.current_state = Builder.STATE.LOCKING
			lock_button.add_theme_color_override("icon_normal_color",Color("ffffff"))
			lock_button.add_theme_color_override("icon_focus_color",Color("ffffff"))
			lock_button.add_theme_color_override("icon_pressed_color",Color("ffffff"))
			lock_button.add_theme_color_override("icon_hover_color",Color("ffffff"))
			lock_button.add_theme_color_override("icon_hover_pressed_color",Color("ffffff"))
		Builder.STATE.LOCKING:
			Builder.current_state = Builder.STATE.BUILDING
			lock_button.add_theme_color_override("icon_normal_color",Color("ffffff50"))
			lock_button.add_theme_color_override("icon_focus_color",Color("ffffff50"))
			lock_button.add_theme_color_override("icon_pressed_color",Color("ffffff50"))
			lock_button.add_theme_color_override("icon_hover_color",Color("ffffff50"))
			lock_button.add_theme_color_override("icon_hover_pressed_color",Color("ffffff50"))
