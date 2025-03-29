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
	Firebase.Auth.save_auth(auth)
	var fn = save_data_user_complete
	save_data_user(fn)


func on_signup_failed(error_code, message):
	print(error_code)
	print(message)

func sig_in_request() -> void:
	var email = email_line.text
	var password = password_line.text
	Firebase.Auth.signup_with_email_and_password(email, password)

func save_data_user(action):
	var document = await get_base_user()
	var user_info = document.doc_fields
	var name_user = username_line.text
	
	
	if user_info.has("name"):
		user_info.name = str(name_user)
	
	await AppManager.global_functions.save_data(ENDPOINT,user_info)
	
	
	action.call()

func save_data_user_complete():
	
	await get_tree().process_frame
	
	var json = await AppManager.global_functions.load_data(AppManager.endpoint.USERS)
	
	if json:
		AppManager.account_controller.json_user = json.doc_fields
	
	AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.MENU)
	
	print("LOCAL >>> ", AppManager.account_controller.json_user)


func get_base_user():
	var collection: FirestoreCollection = Firebase.Firestore.collection(AppManager.endpoint.USERS)
	var task: FirestoreTask = collection.get_doc("UserBase")
	var finished_task: FirestoreTask = await task.task_finished
	var document = finished_task.document
	return document
