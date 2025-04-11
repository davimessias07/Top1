extends MarginContainer

@onready var btn_home: Button = $Buttons/Home
@onready var btn_games: Button = $Buttons/Games
@onready var btn_torneaments: Button = $Buttons/Torneaments

func set_buttons():
	btn_home.connect("pressed",open_home)
	btn_games.connect("pressed",open_games)

func open_home():
	var args = {
		"parent_scene":AppManager.menu.body
	}
	
	AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.HOME,args)

func open_games():
	var args = {
		"parent_scene":AppManager.menu.body,
		"action_complete":{"action":"get_all_games"}
	}
	
	var scene = AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.GAMES,args)
