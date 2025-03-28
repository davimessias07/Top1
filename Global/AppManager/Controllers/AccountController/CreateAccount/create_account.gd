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
	save_data()
	AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.MENU)

func on_signup_failed(error_code, message):
	print(error_code)
	print(message)

func sig_in_request() -> void:
	var email = email_line.text
	var password = password_line.text
	Firebase.Auth.signup_with_email_and_password(email, password)

func save_data():
	
	var auth = Firebase.Auth.auth
	
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(ENDPOINT)
		var data: Dictionary = {
			"username": username_line.text,
			"balance": 100,
			"image":""
		}
		
		var task: FirestoreTask = collection.update(auth.localid,data)

func load_data():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(ENDPOINT)
		var task: FirestoreTask = collection.get_doc(auth.localid)
		var finished_task: FirestoreTask = await task.task_finished
		var document = finished_task.document
		
		if document && document.doc_fields:
			if document.doc_fields.panda_name:
				%PandaNameLineEdit.text = document.doc_fields.panda_name
			else:
				print(finished_task.error)
