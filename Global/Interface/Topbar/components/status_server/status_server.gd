extends MarginContainer

@onready var color_status: Panel = $HBoxContainer/ColorStatus
@onready var status_text: MarginContainer = $HBoxContainer/Status_text


var current_state

var online_setup:Dictionary = {"color_status":Color.GREEN}

@export var font_size:int = 20

func set_status_setup():
	current_state = AppManager.app_data.status
	
	match current_state:
		"online":
			set_color(online_setup.color_status)
			status_text.set_text(current_state,font_size)

func set_color(new_color):
	color_status.self_modulate = new_color
