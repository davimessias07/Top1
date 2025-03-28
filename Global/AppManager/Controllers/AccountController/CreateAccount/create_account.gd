extends MarginContainer
 
@export var email_line:LineEdit
@export var password_line:LineEdit

func _ready():
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.signup_failed.connect(on_signup_failed)

func on_signup_succeeded(auth):
	print(auth)
	Firebase.Auth.save_auth(auth)
	#get_tree().change_scene_to_file("res://Game.tscn")

func on_signup_failed(error_code, message):
	print(error_code)
	print(message)


func _on_sig_in_button_pressed() -> void:
	var email = email_line.text
	var password = password_line.text
	Firebase.Auth.signup_with_email_and_password(email, password)
