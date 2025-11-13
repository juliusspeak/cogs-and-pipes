extends HBoxContainer

func _ready() -> void:
	connectSocialButtons()

func connectSocialButtons():
	for button in get_children():
		if button is Button:
			button.mouse_entered.connect(buttonHoverOn.bind(button))
			button.mouse_exited.connect(buttonHoverOff.bind(button))
			button.pressed.connect(openUrl.bind(button.icon.resource_path.get_file().get_basename()))

func openUrl(iconName: String):
	var url: String
	match iconName:
		"twitter":
			url = "https://x.com/juliusspeak"
		"steam":
			url = "https://store.steampowered.com/developer/sgrade"
		"discord":
			url = "https://discord.gg/snpyubMDCH"
		"itch-io":
			url = "https://sgradegames.itch.io/"
		"vk":
			url = "https://vk.com/sgradegames"
		"youtube":
			url = "https://www.youtube.com/@1electronic"
		"tg":
			url = "https://t.me/jul_gd"
	OS.shell_open(url)
	
func buttonHoverOn(but: Button) -> void:
	if but.icon != null:
		var new_path = get_hover_icon_path(but.icon.resource_path)
		if but.icon.resource_path != new_path:
			var hover_icon: CompressedTexture2D = load(new_path)
			but.icon = hover_icon

func buttonHoverOff(but: Button) -> void:
	if but.icon != null:
		var new_path = get_original_icon_path(but.icon.resource_path)
		if but.icon.resource_path != new_path:
			var original_icon: CompressedTexture2D = load(new_path)
			but.icon = original_icon

func get_hover_icon_path(original_path: String) -> String:
	var extension = original_path.get_extension()
	var base_name = original_path.trim_suffix("." + extension)
	
	# Не добавляем Hover, если уже есть
	if base_name.ends_with("Hover"):
		return base_name + "." + extension
	
	return base_name + "Hover." + extension

func get_original_icon_path(hover_icon_path: String) -> String:
	var extension = hover_icon_path.get_extension()
	var base_name = hover_icon_path.trim_suffix("." + extension)
	
	if base_name.ends_with("Hover"):
		base_name = base_name.trim_suffix("Hover")
	
	return base_name + "." + extension
