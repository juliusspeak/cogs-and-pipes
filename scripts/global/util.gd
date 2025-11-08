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

static func set_file_paths_to_dicts(path: String, extension: String, dict: Dictionary) -> void:
	var files := ResourceLoader.list_directory(path)
	for file in files:
		var full_path = path.trim_suffix("/") + "/" + file
		if file.ends_with("/"):
			set_file_paths_to_dicts(full_path.trim_suffix("/"), extension, dict)
		elif file.get_extension() == extension:
			dict[file.get_basename()] = full_path

static func set_file_paths_to_arr(path: String, extension: String, arr: Array) -> void:
	var files := ResourceLoader.list_directory(path)
	for file in files:
		var full_path = path.trim_suffix("/") + "/" + file
		if file.ends_with("/"):
			set_file_paths_to_arr(full_path.trim_suffix("/"), extension, arr)
		elif file.get_extension() == extension:
			arr.append(full_path)
