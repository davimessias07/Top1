extends Control

@export var feedback_label:MarginContainer
@export var feedback_panel:Panel

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
	hide_feedback()
	
	var email = email_line.text
	var password = password_line.text
	Firebase.Auth.login_with_email_and_password(email, password)

func on_login_succeeded(auth):
	print("Autenticate Success >>> ",auth)
	Firebase.Auth.save_auth(auth)
	var fn = AppManager.load_scene_controller.trade_scene.bind(AppManager.path_scenes.MENU)
	show_feedback("Logado com sucesso. Redirecionando...",Color.WEB_GREEN,fn)
	

func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	show_feedback(message,Color.FIREBRICK)

func show_feedback(new_text,color_label:Color,action:Callable = func():):
	feedback_panel.self_modulate = color_label
	feedback_panel.show()
	feedback_label.set_text(new_text)
	await get_tree().create_timer(2).timeout
	action.call()

func hide_feedback():
	feedback_label.clear_text()
	feedback_panel.hide()
