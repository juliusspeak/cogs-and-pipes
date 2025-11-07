extends Node

func show_locked_cells(lvl: LevelMap) -> void:
	var x: float = 0
	var z: float = 0
	var row = 0
	var column = 0
	for line in lvl.map:
		for bld_num in line:
			var state: MeshInstance3D
			
			if lvl.blocked_cells.has(Vector2i(row,column)):
				instantiate_mark(Vector3(-x,0,-z), "locked")
			else:
				instantiate_mark(Vector3(-x,0,-z), "dot")
			x += 1.4
			
			column += 1
		x = 0
		z += 1.4
		
		row += 1
		column = 0

func instantiate_mark(pos: Vector3, mark_name: String) -> void:
	var mark: MeshInstance3D
	mark = ResourceLoader.load("res://scenes/particles/"+ mark_name + ".tscn").instantiate()
	mark.position = pos
	GlobalData.levelMapController.add_child(mark)
