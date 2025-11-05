extends Node

static func get_opposite_dir(dir):
	if dir == 2:
		return 0
	elif dir == 0:
		return 2
	elif dir == 1:
		return 3
	elif dir == 3:
		return 1
