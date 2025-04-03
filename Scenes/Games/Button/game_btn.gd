extends TextureRect

@onready var button: Button = $Button
@onready var label_defaut: MarginContainer = $LabelDefaut

var game_infos 

func set_attrs(attrs):
	game_infos = attrs
	button.connect("pressed",btn_pressed)
	label_defaut.set_text(attrs.game_name)

func btn_pressed():
	var scene = await AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.MODES)
	scene.get_all_modes(game_infos.modes)
