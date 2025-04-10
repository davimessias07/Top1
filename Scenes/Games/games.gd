extends ScrollContainer

const GAME_BTN = preload("uid://cmo1j8x7oeji7")

@onready var screen_grid_horizontal: HBoxContainer = $ScreenGridVertical/ScreenGridHorizontal
@onready var name_screen: MarginContainer = $ScreenGridVertical/NameScreen

@export var screen_name:String = ""
@export var screen_name_font_size:int = 30

func get_all_games():
	if screen_name != "":
		set_name_screen()
	
	var collection = await AppManager.global_functions.get_doc(AppManager.endpoint.GAMES,"all_games")
	for game in collection.doc_fields.games:
		var scene = GAME_BTN.instantiate()
		screen_grid_horizontal.add_child(scene)
		scene.set_attrs(game)

func set_name_screen():
	name_screen.set_text(screen_name,screen_name_font_size)
	name_screen.show()
