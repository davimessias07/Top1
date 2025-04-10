extends MarginContainer
@onready var room_name: Control = $ScreenGridVertical/RoomName
@onready var host: Control = $ScreenGridVertical/Users/ScreenGridHorizontal/Host

func set_room_attr(attrs):
	room_name.set_text(attrs.value.name_room)
	host.start_setup(AppManager.account_controller.data_user)
