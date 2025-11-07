@tool
extends Button

@export_enum("null",
"TWO_SIDE_PIPE",
"WATERMILL",
"ALL_SIDE_COGS",
"ALL_SIDE_SHAFTS",
"BIG_COG",
"SIDE_SHAFT_SIDE_COGS",
"TWO_SIDE_SHAFTS",
"PUMP",
"CORNER_PIPE",
"TWO_SIDE_COGS",
"SIDE_COG_SIDE_SHAFTS",
"TWO_SIDE_COG_SHAFT",
"CORNER_COGS",
"CORNER_SHAFTS",
"CORNER_SHAFT_COG",
"CORNER_COG_SHAFT",
"BLOCK",
"TWO_SIDE_PIPE_WITH_COGS",
"THREE_SIDE_PIPE",) var build_num: int
var build_res_keys = BUILDING_RES.LINK.keys()

@export var sub_button: Button
@export var num_label: Label
@export var add_button: Button

func _ready() -> void:
	self.icon = ResourceLoader.load("res://assets/images/ui/buildings/" + build_res_keys[build_num] + ".png")

func _on_pressed() -> void:
	Builder.current_building = int(build_num)


func _on_add_button_pressed() -> void:
	num_label.text = str(int(num_label.text) + 1)


func _on_sub_button_pressed() -> void:
	if int(num_label.text) > 0:
		num_label.text = str(int(num_label.text) - 1)
