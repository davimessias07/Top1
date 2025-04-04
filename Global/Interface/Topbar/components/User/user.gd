extends MarginContainer

@onready var username: MarginContainer = $ScreenGridHorizontal/ScreenGridVertical/username
@onready var balance: MarginContainer = $ScreenGridHorizontal/ScreenGridVertical/balance
@onready var circle: TextureRect = $ScreenGridHorizontal/Circle

var user_info

var current_prefix = "R$ "

func set_user_attrs():
	user_info = AppManager.account_controller.data_user
	var balance_text = current_prefix + str(user_info.balance)
	username.set_text(user_info.name,20)
	balance.set_text(balance_text,20)
