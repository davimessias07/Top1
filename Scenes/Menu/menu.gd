extends CanvasLayer
#
#var player_status: Dictionary = {}
var player_id = ""
#var db_games = Firebase.Database.get_database_reference("Games")
#
func _ready() -> void:
	player_id = Firebase.Auth.auth.localid
	#
	#db_games.new_data_update.connect(new_data_updated)
	#db_games.patch_data_update.connect(patch_data_updated)
#
#func new_data_updated(data):
	#print("new_data_updated")
	#print(data)
	##check_state_button(data)
#
#func patch_data_updated(data):
	#print("patch_data_updated")
	#print(data)
	##check_state_button(data)
#
#
##func _on_r_6_pressed() -> void:
	##db_games.update("R6",{"is_visible":!r_6.visible})
##
##func check_state_button(state):
	##match state.key:
		##"R6":
			##var visible_state = state.data.is_visible
			##r_6.visible = visible_state
			##printerr(visible_state)
		##"R6/is_visible":
			##var visible_state = state.data
			##r_6.visible = visible_state
			##printerr(visible_state)
	#
