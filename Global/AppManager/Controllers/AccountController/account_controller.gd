extends Node

var data_user

func get_state_login() -> bool:
	return Firebase.Auth.check_auth_file()

func open_login_scene():
	AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.LOGIN)

func open_create_account_scene():
	AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.CREATE_ACCOUNT)

func logout():
	Firebase.Auth.logout()
	AppManager.account_controller.open_login_scene()
