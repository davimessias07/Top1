extends Node

func get_user_data(action:Callable):
	var base = await load_data(AppManager.endpoint.USERS)
	if base && base.doc_fields:
		AppManager.account_controller.data_user = base.doc_fields
		action.call()

func get_app_data(action:Callable):
	var doc = "app_data"
	var base = await load_data(AppManager.endpoint.APP,doc)
	if base && base.doc_fields:
		AppManager.app_data = base.doc_fields
	
	action.call()

func save_data(endpoint:String,data:Dictionary):
	var auth = Firebase.Auth.auth
	
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(endpoint)
		var task: FirestoreTask = collection.update(auth.localid,data)

func load_data(endpoint:String,doc = Firebase.Auth.auth.localid):
	var document = null
	var auth = Firebase.Auth.auth
	
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(endpoint)
		var task: FirestoreTask = collection.get_doc(doc)
		var finished_task: FirestoreTask = await task.task_finished
		document = finished_task.document
		
		if document && document.doc_fields:
			print("Documento >>> ",document.doc_fields)
		else:
			print("documento n encontrado ",finished_task.error)
			
			#if finished_task.error.status == "NOT_FOUND":
				#match finished_task.error.code:
					#"404":
						#print("ARQUIVO NÃO ENCONTRADO")
	return document

func get_doc(endpoint,doc):
	var collection: FirestoreCollection = Firebase.Firestore.collection(endpoint)
	var task: FirestoreTask = collection.get_doc(doc)
	var finished_task: FirestoreTask = await task.task_finished
	var document = finished_task.document
	return document

var isForceClearCache: bool = false
var user_resource: UserImg = UserImg.new()

func getRemoteImage(url: String,cover_image):
	
	if url == "":
		return
	
	var imageUrl = str(url)
	var fileName = imageUrl.get_file()
	var filePath = AppManager.cache.cache_img_user + fileName
	
	if isForceClearCache:
		if FileAccess.file_exists(filePath):
			print("deleta cache..." + filePath)
			DirAccess.remove_absolute(filePath)
	if FileAccess.file_exists(filePath):
		setImageFromFilePathToImageNodeInstance(filePath,cover_image)
	else:
		print("NOVA IMAGEM >>> ", url)
		AppManager.http_manager.connect("completed", onImageLoadComplete.bind(imageUrl,cover_image))
		base(url).download(filePath)

func setImageFromFilePathToImageNodeInstance(filePath: String,cover_image):
	var imagepath = Image.load_from_file(filePath)
	var textureimage = ImageTexture.create_from_image(imagepath)
	
	if cover_image != null:
		cover_image.texture = textureimage
	else:
		print("cover_image nulo")

func onImageLoadComplete(imageUrl,cover_image):
	var fileName = imageUrl.get_file()
	var filePath = AppManager.cache.cache_img_user + fileName
	
	if FileAccess.file_exists(filePath):
		setImageFromFilePathToImageNodeInstance(filePath,cover_image)
	else:
		print("não achou a imagem localmente mesmo depois de ter baixado da url = " + imageUrl)

func base(url: String) -> HTTPManagerJob:
	return (
		AppManager.http_manager
		. job(url)
		. mime("application/json")
	)
