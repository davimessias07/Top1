extends Control
 

@export var state_login:Label

@export var email_line:LineEdit
@export var password_line:LineEdit

@export var login_btn:Button
@export var create_account_btn:Button

func _ready():
	connect_signal()

func connect_signal():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	login_btn.connect("pressed",login_request)
	create_account_btn.connect("pressed",AppManager.account_controller.open_create_account_scene)

func login_request():
	var email = email_line.text
	var password = password_line.text
	Firebase.Auth.login_with_email_and_password(email, password)
	state_login.text = "Logging in"

func on_login_succeeded(auth):
	print(auth)
	state_login.text = "Login success!"
	Firebase.Auth.save_auth(auth)
	AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.MENU)

func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	state_login.text = "Login failed. Error: %s" % message
