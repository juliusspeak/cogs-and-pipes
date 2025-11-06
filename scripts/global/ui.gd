extends Control

var scenes: Dictionary

func _ready() -> void:
	GlobalData.ui = self
	GlobalData.levelMapController.level_passed.connect(level_passed)
	GlobalData.state_changed.connect(change_state)
	Util.set_file_paths_to_dicts("res://scenes/ui/","tscn",scenes)
	
	show_menu()

func level_passed() -> void:
	window_message("key_you_win","3 stars",{"ok": func(parent): parent.queue_free()})

func instantiate_ui(ui_name: String) -> Control:
	var ui = ResourceLoader.load(scenes[ui_name]).instantiate()
	add_child(ui)
	return ui

func window_message(title: String, content: String, buttons: Dictionary):
	var window = instantiate_ui("window_message")
	window.title_label.text = title
	window.content_label.text = content
	for btn_name in buttons:
		var button = Button.new()
		button.text = btn_name
		window.buttons_list.add_child(button)
		button.pressed.connect(buttons[btn_name].bind(window))
	return window

func clear_all() -> void:
	for n in get_children():
		n.queue_free()

func show_menu() -> void:
	var menu: Control = instantiate_ui("main_menu")
	menu.select_level_button.pressed.connect(func(): GlobalData.current_state = GlobalData.STATE.LEVELSELECT)

func show_levels() -> void:
	var select_levels: Control = instantiate_ui("select_levels")
	select_levels.back_button.pressed.connect(func(): GlobalData.current_state = GlobalData.STATE.MENU)
	var grid: GridContainer = select_levels.grid_container
	for lvl_link in GlobalData.levelMapController.levels:
		var lvl = ResourceLoader.load(lvl_link)
		
		var lvl_button = Button.new()
		lvl_button.custom_minimum_size = Vector2(200,200)
		grid.add_child(lvl_button)
		
		lvl_button.text = tr("key_passed") + ": " + str(lvl.passed) + "\n" + tr("key_stars") + ": " + str(lvl.stars)
		lvl_button.pressed.connect(func():
			GlobalData.levelMapController.current_lvl_map = lvl;
			GlobalData.current_state = GlobalData.STATE.GAME)

func change_state(state: GlobalData.STATE):
	clear_all()
	match state:
		GlobalData.STATE.MENU:
			show_menu()
		GlobalData.STATE.LEVELSELECT:
			show_levels()
		GlobalData.STATE.GAME:
			pass
