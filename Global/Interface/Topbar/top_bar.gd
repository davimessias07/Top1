extends MarginContainer

@onready var logo_img: TextureRect = $Logo/LogoImg
@onready var status_server: MarginContainer = $ScreenGridHorizontal/StatusServer
@onready var user: MarginContainer = $ScreenGridHorizontal/User
@onready var scenes_buttons: MarginContainer = $ScreenGridHorizontal/scenes_buttons

@onready var screen_grid_horizontal: HBoxContainer = $ScreenGridHorizontal

func start_setup():
	status_server.set_status_setup()
	user.set_user_attrs()
	scenes_buttons.set_buttons()
	var img = user.circle.image_user
	AppManager.global_functions.getRemoteImage(AppManager.account_controller.data_user.image,img)

func hide_infos():
	screen_grid_horizontal.hide()
