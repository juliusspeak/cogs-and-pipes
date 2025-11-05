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
"CORNER_COG_SHAFT",) var build_num: int
var build_res_keys = BUILDING_RES.LINK.keys()


func _ready() -> void:
	self.icon = ResourceLoader.load("res://assets/images/ui/buildings/" + build_res_keys[build_num] + ".png")

func _on_pressed() -> void:
	Builder.current_building = int(build_num)
