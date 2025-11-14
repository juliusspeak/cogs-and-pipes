extends Panel
@export var grid_container: GridContainer
@export var back_button: Button
@export var lvl_code: TextEdit



func _on_button_pressed() -> void:
	var lvl = Util.string_to_res(lvl_code.text)
	if lvl is LevelMap:
		GlobalData.levelMapController.current_lvl_map = lvl
		GlobalData.levelMapController.clean_lvl()
		GlobalData.current_state = GlobalData.STATE.LOADGAME


func _on_paste_button_pressed() -> void:
	lvl_code.text = DisplayServer.clipboard_get()
