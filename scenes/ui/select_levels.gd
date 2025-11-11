extends Panel
@export var grid_container: GridContainer
@export var back_button: Button



func _on_button_pressed() -> void:
	var lvl = Util.string_to_res($MarginContainer/ScrollContainer/GridContainer/OneLvlBtn/lvlCode.text)
	if lvl is LevelMap:
		GlobalData.levelMapController.current_lvl_map = lvl
		GlobalData.levelMapController.clean_lvl()
		GlobalData.current_state = GlobalData.STATE.LOADGAME
