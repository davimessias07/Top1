extends CanvasLayer

var player_status: Dictionary = {}
var player_id = ""
var db_ref = Firebase.Database.get_database_reference("Games")
@onready var r_6: Button = $BaseModal/BG/ScreenGridVertical/ScreenGridHorizontal/Body/ScreenGridHorizontal/R6


func _ready() -> void:
	player_id = Firebase.Auth.auth.localid
	db_ref.new_data_update.connect(new_data_updated)
	db_ref.patch_data_update.connect(patch_data_updated)

func new_data_updated(data_base):
	print("new_data_updated")
	print(data_base)
	r_6.visible = data_base.data.is_visible

func patch_data_updated(data):
	print("patch_data_updated")
	check_state_button(data)

func _on_r_6_pressed() -> void:
	db_ref.update("R6", {"is_visible":false})

func check_state_button(data_local):
	r_6.visible = data_local.data
