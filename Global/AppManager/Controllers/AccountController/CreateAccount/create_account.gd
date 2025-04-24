extends MarginContainer

@export var email_line:LineEdit
@export var password_line:LineEdit
@export var username_line:LineEdit
@export var sign_in_button:Button
@onready var top_bar: MarginContainer = $BaseModal/BG/ScreenGridVertical/TopBar

@onready var btn_select_image: Button = $BaseModal/BG/ScreenGridVertical/CreateAccount/ScreenGridVertical/Body/ScreenGridVertical/Image/ScreenGridVertical/btnSelectImage

func _ready():
	top_bar.hide_infos()
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	sign_in_button.connect("pressed",sig_in_request)
	btn_select_image.connect("pressed",show_all_images)

func show_all_images():
	var arr_imgs = await get_all_images()
	print("ARRAY DE IMGS ", arr_imgs)
	if arr_imgs != null and len(arr_imgs) > 0:
		for img in arr_imgs:
			print("Imagem >>> ", img)

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
	
	await AppManager.global_functions.save_data(AppManager.endpoint.USERS,user_info)
	
	
	action.call()

func save_data_user_complete():
	
	await get_tree().process_frame
	
	var json = await AppManager.global_functions.load_data(AppManager.endpoint.USERS)
	
	if json:
		AppManager.account_controller.data_user = json.doc_fields
	
	AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.MENU)
	
	print("LOCAL >>> ", AppManager.account_controller.data_user)


func get_base_user():
	var collection: FirestoreCollection = Firebase.Firestore.collection(AppManager.endpoint.USERS)
	var task: FirestoreTask = collection.get_doc("user_base")
	var finished_task: FirestoreTask = await task.task_finished
	var document = finished_task.document
	return document

func get_all_images():
	var collection: FirestoreCollection = Firebase.Firestore.collection(AppManager.endpoint.APP)
	var task: FirestoreTask = collection.get_doc("default_imgs")
	var finished_task: FirestoreTask = await task.task_finished
	var document = finished_task.document
	return document
