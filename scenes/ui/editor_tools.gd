extends VBoxContainer
@export var lock_button: Button
@export var goal_button: Button


func _on_lock_button_pressed() -> void:
	match Builder.current_state:
		Builder.STATE.BUILDING:
			Builder.current_state = Builder.STATE.LOCKING
		Builder.STATE.LOCKING:
			Builder.current_state = Builder.STATE.BUILDING
		Builder.STATE.GOALS:
			Builder.current_state = Builder.STATE.LOCKING
	change_icon_colors()

func _on_goal_button_pressed() -> void:
	match Builder.current_state:
		Builder.STATE.BUILDING:
			Builder.current_state = Builder.STATE.GOALS
		Builder.STATE.LOCKING:
			Builder.current_state = Builder.STATE.GOALS
		Builder.STATE.GOALS:
			Builder.current_state = Builder.STATE.BUILDING
	change_icon_colors()

func change_icon_colors() -> void:
	match Builder.current_state:
		Builder.STATE.BUILDING:
			lock_button.add_theme_color_override("icon_normal_color",Color("ffffff50"))
			lock_button.add_theme_color_override("icon_focus_color",Color("ffffff50"))
			lock_button.add_theme_color_override("icon_pressed_color",Color("ffffff50"))
			lock_button.add_theme_color_override("icon_hover_color",Color("ffffff50"))
			lock_button.add_theme_color_override("icon_hover_pressed_color",Color("ffffff50"))
			goal_button.add_theme_color_override("icon_normal_color",Color("ffffff50"))
			goal_button.add_theme_color_override("icon_focus_color",Color("ffffff50"))
			goal_button.add_theme_color_override("icon_pressed_color",Color("ffffff50"))
			goal_button.add_theme_color_override("icon_hover_color",Color("ffffff50"))
			goal_button.add_theme_color_override("icon_hover_pressed_color",Color("ffffff50"))
		Builder.STATE.LOCKING:
			lock_button.add_theme_color_override("icon_normal_color",Color("ffffff"))
			lock_button.add_theme_color_override("icon_focus_color",Color("ffffff"))
			lock_button.add_theme_color_override("icon_pressed_color",Color("ffffff"))
			lock_button.add_theme_color_override("icon_hover_color",Color("ffffff"))
			lock_button.add_theme_color_override("icon_hover_pressed_color",Color("ffffff"))
			goal_button.add_theme_color_override("icon_normal_color",Color("ffffff50"))
			goal_button.add_theme_color_override("icon_focus_color",Color("ffffff50"))
			goal_button.add_theme_color_override("icon_pressed_color",Color("ffffff50"))
			goal_button.add_theme_color_override("icon_hover_color",Color("ffffff50"))
			goal_button.add_theme_color_override("icon_hover_pressed_color",Color("ffffff50"))
		Builder.STATE.GOALS:
			lock_button.add_theme_color_override("icon_normal_color",Color("ffffff50"))
			lock_button.add_theme_color_override("icon_focus_color",Color("ffffff50"))
			lock_button.add_theme_color_override("icon_pressed_color",Color("ffffff50"))
			lock_button.add_theme_color_override("icon_hover_color",Color("ffffff50"))
			lock_button.add_theme_color_override("icon_hover_pressed_color",Color("ffffff50"))
			goal_button.add_theme_color_override("icon_normal_color",Color("ffffff"))
			goal_button.add_theme_color_override("icon_focus_color",Color("ffffff"))
			goal_button.add_theme_color_override("icon_pressed_color",Color("ffffff"))
			goal_button.add_theme_color_override("icon_hover_color",Color("ffffff"))
			goal_button.add_theme_color_override("icon_hover_pressed_color",Color("ffffff"))
