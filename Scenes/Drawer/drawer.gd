extends MarginContainer

const ENDPOINT = "Users"

@export var btn_logout:Button

func connect_buttons():
	btn_logout.connect("pressed",AppManager.account_controller.logout)

func _ready() -> void:
	connect_buttons()
	var json = await AppManager.global_functions.load_data(ENDPOINT)
	AppManager.account_controller.json_user = json
	print("LOCAL >>> ", AppManager.account_controller.json_user)
