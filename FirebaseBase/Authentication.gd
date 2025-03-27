extends Control
 
@export var state_login:Label
@export var email_line:LineEdit
@export var password_line:LineEdit

func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	
	#if Firebase.Auth.check_auth_file():
		#state_login.text = "Logged in"
		#get_tree().change_scene_to_file("res://Game.tscn")

func _on_login_button_pressed():
	var email = email_line.text
	var password = password_line.text
	Firebase.Auth.login_with_email_and_password(email, password)
	state_login.text = "Logging in"


func on_login_succeeded(auth):
	state_login.text = "Login success!"
	Firebase.Auth.save_auth(auth)
	#get_tree().change_scene_to_file("res://FirebaseBase/Game.tscn")

func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	state_login.text = "Login failed. Error: %s" % message

func _on_logout_button_pressed() -> void:
	Firebase.Auth.logout()
	get_tree().reload_current_scene()
