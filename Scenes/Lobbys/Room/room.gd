extends MarginContainer
@onready var room_name: Control = $ScreenGridVertical/RoomName
@onready var host: Control = $ScreenGridVertical/Users/ScreenGridHorizontal/Host
#@onready var user_2: MarginContainer = $ScreenGridVertical/Users/ScreenGridHorizontal/User2


func set_room_attr(attrs):
	return
	room_name.set_text(attrs.value.name_room)
	host.start_setup(AppManager.account_controller.data_user)
	#user_2.username.set_text("Procurando Jogadores...",10)
