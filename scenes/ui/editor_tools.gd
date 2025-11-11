extends Control

@export var get_lvl_button: Button
@export var lvl_line_edit: LineEdit

@export var lock_button: Button
@export var goal_button: Button

@export var sub_button0: Button
@export var label0: Label
@export var add_button0: Button

@export var sub_button1: Button
@export var label1: Label
@export var add_button1: Button

@export var sub_button2: Button
@export var label2: Label
@export var add_button2: Button

func _ready() -> void:
	sub_button0.pressed.connect(change_count.bind(label0,"-"))
	add_button0.pressed.connect(change_count.bind(label0,"+"))
	
	sub_button1.pressed.connect(change_count.bind(label1,"-"))
	add_button1.pressed.connect(change_count.bind(label1,"+"))
	
	sub_button2.pressed.connect(change_count.bind(label2,"-"))
	add_button2.pressed.connect(change_count.bind(label2,"+"))

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

func change_count(lbl: Label, operand: String) -> void:
	var num = int(lbl.text)
	
	match operand:
		"+":
			num += 1
		"-":
			if num <= 0:
				num = 0
			else:
				num -= 1
	
	lbl.text = str(num)


func _on_get_lvl_button_pressed() -> void:
	var lvl: LevelMap = GlobalData.levelMapController.current_lvl_map
	lvl.stars_conditions[1] = int(label0.text)
	lvl.stars_conditions[2] = int(label1.text)
	lvl.stars_conditions[3] = int(label2.text)
	lvl_line_edit.text = Util.res_to_string(lvl)
