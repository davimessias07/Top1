extends ScrollContainer

const GAME_BTN = preload("uid://cmo1j8x7oeji7")
@onready var screen_grid_horizontal: HBoxContainer = $ScreenGridHorizontal

func _ready() -> void:
	get_all_games()

func get_all_games():
	var collection = await AppManager.global_functions.get_doc(AppManager.endpoint.GAMES,"all_games")
	for game in collection.doc_fields.games:
		var scene = GAME_BTN.instantiate()
		screen_grid_horizontal.add_child(scene)
		scene.set_attrs(game)
