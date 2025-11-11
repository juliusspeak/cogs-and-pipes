extends HBoxContainer

func _ready() -> void:
	if GlobalData.current_state != GlobalData.STATE.EDITOR:
		Builder.build_block.connect(sub_block)
		Builder.demolish_block.connect(add_block)
	set_up()

func set_up() -> void:
	for button in get_children():
		var count: Label = button.num_label
		var bld_name = BUILDING_RES.LINK.keys()[button.build_num]
		
		var build_limit: Dictionary = GlobalData.levelMapController.current_lvl_map.build_limit
		count.text = str(build_limit[bld_name])
		
		if GlobalData.current_state != GlobalData.STATE.EDITOR:
			button.sub_button.visible = false
			button.add_button.visible = false
			update_visibility()

func add_block(block_name: int) -> void:
	for button in get_children():
		if button.build_num == block_name:
			var count: Label = button.num_label
			count.text = str(int(count.text) + 1)
	update_visibility()

func sub_block(block_name: int) -> void:
	for button in get_children():
		if button.build_num == block_name:
			var count: Label = button.num_label
			count.text = str(int(count.text) - 1)
			if int(count.text) == 0 and Builder.current_building == button.build_num:
				Builder.current_building = 0
	update_visibility()

func update_visibility() -> void:
	for button in get_children():
		var count: Label = button.num_label
		if int(count.text) > 0:
			button.visible = true
		else:
			button.visible = false
