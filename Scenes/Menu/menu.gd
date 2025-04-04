extends CanvasLayer

var player_id = ""
@onready var top_bar: MarginContainer = $BaseModal/BG/ScreenGridVertical/TopBar
@onready var body: MarginContainer = $BaseModal/BG/ScreenGridVertical/ScreenGridHorizontal/Body

func _ready() -> void:
	AppManager.menu = self
	player_id = Firebase.Auth.auth.localid
	AppManager.global_functions.get_app_data(set_attrs_top_bar)

func set_attrs_top_bar():
	top_bar.start_setup()
