extends HBoxContainer

func _ready() -> void:
	Builder.build_block.connect(sub_block)
	Builder.demolish_block.connect(add_block)
	set_up()

func set_up() -> void:
	for button in get_children():
		var count: Label = button.get_child(0)
		var bld_name = BUILDING_RES.LINK.keys()[button.build_num]
		var build_limit: Dictionary = GlobalData.levelMapController.current_lvl_map.build_limit
		count.text = str(build_limit[bld_name])
	update_visibility()

func add_block(block_name: int) -> void:
	for button in get_children():
		if button.build_num == block_name:
			var count: Label = button.get_child(0)
			count.text = str(int(count.text) + 1)
	update_visibility()

func sub_block(block_name: int) -> void:
	for button in get_children():
		if button.build_num == block_name:
			var count: Label = button.get_child(0)
			count.text = str(int(count.text) - 1)
	update_visibility()

func update_visibility() -> void:
	for button in get_children():
		var count: Label = button.get_child(0)
		if int(count.text) > 0:
			button.visible = true
		else:
			button.visible = false
