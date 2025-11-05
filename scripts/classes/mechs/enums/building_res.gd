class_name BUILDING_RES

const LINK = {
	NOONE = "",
	TWO_SIDE_PIPE = "res://scenes/objects/two_side_pipe.tscn",
	WATERMILL = "res://scenes/objects/watermill.tscn",
	ALL_SIDE_COGS = "res://scenes/objects/all_side_cogs.tscn",
	ALL_SIDE_SHAFTS = "res://scenes/objects/all_side_shafts.tscn",
	BIG_COG = "res://scenes/objects/big_cog.tscn",
	SIDE_SHAFT_SIDE_COGS = "res://scenes/objects/side_shaft_side_cogs.tscn",
	TWO_SIDE_SHAFTS = "res://scenes/objects/two_side_shafts.tscn",
	PUMP = "res://scenes/objects/pump.tscn",
	CORNER_PIPE = "res://scenes/objects/corner_pipe.tscn",
	TWO_SIDE_COGS = "res://scenes/objects/two_side_cogs.tscn",
	SIDE_COG_SIDE_SHAFTS = "res://scenes/objects/side_cog_side_shafts.tscn",
	TWO_SIDE_COG_SHAFT = "res://scenes/objects/two_side_cog_shaft.tscn",
	CORNER_COGS = "res://scenes/objects/corner_cogs.tscn",
	CORNER_SHAFTS = "res://scenes/objects/corner_shafts.tscn",
	CORNER_SHAFT_COG = "res://scenes/objects/corner_shaft_cog.tscn",
	CORNER_COG_SHAFT = "res://scenes/objects/corner_cog_shaft.tscn",
	BLOCK = "res://scenes/objects/block.tscn",
}

static func get_link(bld_num) -> String:
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
				9:
					res_link = BUILDING_RES.LINK.CORNER_PIPE
				10:
					res_link = BUILDING_RES.LINK.TWO_SIDE_COGS
				11:
					res_link = BUILDING_RES.LINK.SIDE_COG_SIDE_SHAFTS
				12:
					res_link = BUILDING_RES.LINK.TWO_SIDE_COG_SHAFT
				13:
					res_link = BUILDING_RES.LINK.CORNER_COGS
				14:
					res_link = BUILDING_RES.LINK.CORNER_SHAFTS
				15:
					res_link = BUILDING_RES.LINK.CORNER_SHAFT_COG
				16:
					res_link = BUILDING_RES.LINK.CORNER_COG_SHAFT
				17:
					res_link = BUILDING_RES.LINK.BLOCK
					
	return res_link
