extends MarginContainer

@onready var circle: TextureRect = $Button/Circle
@onready var button: Button = $Button
@onready var infos: Control = $"../../../Infos"

var user_info

var current_prefix = "R$ "

func set_user_attrs():
	user_info = AppManager.account_controller.data_user
	button.connect("pressed",btn_pressed)

func btn_pressed():
	infos.visible = !infos.visible
