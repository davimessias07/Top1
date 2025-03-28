extends MarginContainer

const ENDPOINT = "Users"

@export var email_line:LineEdit
@export var password_line:LineEdit
@export var username_line:LineEdit
@export var sign_in_button:Button

func _ready():
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	sign_in_button.connect("pressed",sig_in_request)

func on_signup_succeeded(auth):
	print(auth)
	Firebase.Auth.save_auth(auth)
	save_data_user()
	AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.MENU)

func on_signup_failed(error_code, message):
	print(error_code)
	print(message)

func sig_in_request() -> void:
	var email = email_line.text
	var password = password_line.text
	Firebase.Auth.signup_with_email_and_password(email, password)

func save_data_user():
	
	var user_info: Dictionary = {
		"username": username_line.text,
		"balance": 100,
		"image":""
	}
	
	AppManager.global_functions.load_data(ENDPOINT,user_info)
