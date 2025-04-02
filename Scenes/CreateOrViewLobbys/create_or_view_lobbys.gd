extends Control

@onready var create_lobby: MarginContainer = $BaseModal/BG/ScreenGridVertical/Body/ScreenGridHorizontal/CreateLobby

var player_id = ""
var db_ref = Firebase.Database.get_database_reference("Games/R6/lobbys/1vs1/rooms")
var data_infos

func _ready() -> void:
	player_id = Firebase.Auth.auth.localid
	db_ref.new_data_update.connect(new_data_updated)
	db_ref.patch_data_update.connect(patch_data_updated)
	set_buttons()

func new_data_updated(data):
	print("new_data_updated")
	data_infos = data
	print(data)

func patch_data_updated(data):
	print("patch_data_updated")
	print(data)

func set_buttons():
	create_lobby.button.connect("pressed",create_room)

func create_room():
	var match_attrs = {
		"id_room":0,
		"name_room": AppManager.account_controller.json_user.name
	}
	
	await db_ref.update(player_id,match_attrs)
	
	var scene = await AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.LOBBYS)
	scene.instance_lobbys()
