extends Node3D
class_name LevelMapLoader

var current_lvl_map: LevelMap

func _ready() -> void:
	GlobalData.levelMapLoader = self
	load_lvl(ResourceLoader.load("res://assets/maps/0.tres"))

func clear_lvl() -> void:
	for n in get_children():
		n.queue_free()

func load_lvl(lvl_map: LevelMap) -> void:
	clear_lvl()
	current_lvl_map = lvl_map
	
	var x: float = 0
	var z: float = 0
	for line in lvl_map.map:
		for bld_num in line:
			var res_link: String = ""
			match bld_num:
				0:
					res_link = ""
				1:
					res_link = BUILDING_RES.LINK.TWO_SIDE_PIPE
				2:
					res_link = BUILDING_RES.LINK.WATERMILL
				3:
					res_link = BUILDING_RES.LINK.ALL_SIDE_COGS
				4:
					res_link = BUILDING_RES.LINK.ALL_SIDE_SHAFTS
				5:
					res_link = BUILDING_RES.LINK.BIG_COG
				6:
					res_link = BUILDING_RES.LINK.SIDE_SHAFT_SIDE_COGS
				7:
					res_link = BUILDING_RES.LINK.TWO_SIDE_SHAFTS
				8:
					res_link = BUILDING_RES.LINK.PUMP
			
			if res_link != "":
				var build = ResourceLoader.load(res_link).instantiate()
				add_child(build)
				build.position = Vector3(-x,0,-z)
			
			x += 1.4
		x = 0
		z += 1.4

func update_map() -> void:
	load_lvl(current_lvl_map)
