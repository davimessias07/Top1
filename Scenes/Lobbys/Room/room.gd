extends Panel
@onready var room_name: MarginContainer = $ScreenGridVertical/RoomName

func set_room_attr(attrs):
	room_name.set_text(attrs.value.name_room)
