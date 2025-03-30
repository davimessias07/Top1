extends CanvasLayer

var player_status: Dictionary = {}
var player_id = ""
var db_ref = Firebase.Database.get_database_reference("match_base")

func _ready() -> void:
	player_id = Firebase.Auth.auth.localid
	# connect both signals to data_updated instead,
	# if you don't want to deal with the parsing in new_data_udpate and patch_data_update
	db_ref.new_data_update.connect(new_data_updated)
	db_ref.patch_data_update.connect(patch_data_updated)

func new_data_updated(data):
	print("new_data_updated")
	print(data)

func patch_data_updated(data):
	print("patch_data_updated")
	print(data)
