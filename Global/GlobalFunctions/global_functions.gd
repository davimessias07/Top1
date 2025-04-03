extends Node

func get_remote_user_attrs(action:Callable):
	var base = await load_data(AppManager.endpoint.USERS)
	if base && base.doc_fields:
		AppManager.account_controller.json_user = base.doc_fields
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
						#pass
	
	return document

func get_doc(endpoint,doc):
	var collection: FirestoreCollection = Firebase.Firestore.collection(endpoint)
	var task: FirestoreTask = collection.get_doc(doc)
	var finished_task: FirestoreTask = await task.task_finished
	var document = finished_task.document
	return document

var isForceClearCache: bool = false

#func getRemoteImage(url: String,cover_image,is3d:bool = false):
#
	#var urlErrorTo = "https://mobtex-sites.s3.amazonaws.com/c3_FQ1CeHZC5M6J1rUuXMTi81717400766665d74be8acc6_ewre4gv1123.jpg"
#
	#if url.length() == 0:
		#return
#
	#var imageUrl = str(url)
	#var fileName = imageUrl.get_file()
	#var filePath = Mobtex.cache.cacheDir + fileName
#
	#if isForceClearCache:
		#if FileAccess.file_exists(filePath):
			#print("deleta cache..." + filePath)
			#DirAccess.remove_absolute(filePath)
#
	#if FileAccess.file_exists(filePath):
		#setImageFromFilePathToImageNodeInstance(filePath,cover_image,is3d)
	#else:
		#print("NOVA IMAGEM >>> ", url)
		#Mobtex.getHttp().getHttpManager().connect("completed", onImageLoadComplete.bind(imageUrl,cover_image,is3d))
		#Mobtex.getHttp().baseTexture(url).download(filePath)
#
#func setImageFromFilePathToImageNodeInstance(filePath: String,cover_image,is3d):
	#var imagepath = Image.load_from_file(filePath)
	#var textureimage = ImageTexture.create_from_image(imagepath)
#
	#if is3d == false:
		#if cover_image != null:
			#cover_image.texture = textureimage
		#else:
			#print("cover_image nulo")
	#else:
			#if cover_image != null:
				#cover_image.albedo_texture = textureimage
			#else:
				#print("cover_image nula")
#
#func onImageLoadComplete(imageUrl,cover_image,is3d):
	#var fileName = imageUrl.get_file()
	#var filePath = Mobtex.cache.cacheDir + fileName
#
	#if FileAccess.file_exists(filePath):
		#setImageFromFilePathToImageNodeInstance(filePath,cover_image,is3d)
	#else:
		#print("não achou a imagem localmente mesmo depois de ter baixado da url = " + imageUrl)
#[13:24]Kng: static var is_dark_mode = false
#
#func check_dark_mode():
	#var theme_mode = DisplayServer.is_dark_mode()  # Pega o tema do sistema
#
	#if theme_mode == true:
		#BaseAPP.color_theme = BaseAPP.dark_theme
		#print("O sistema está no modo escuro!")
		#is_dark_mode = true
	#else:
		#BaseAPP.color_theme = BaseAPP.light_theme
		#is_dark_mode = false
		#print("O sistema está no modo claro!")
#
#"Controller image API and SetImage Object"
#
#var isForceClearCacheall: bool = false
#
#func getMultipleRemoteImage(arrImages,fn:Callable = func():):
#
	#var totalLoad = 0
#
	#for url in arrImages:
		#var imageUrl = str(url)
		#var fileName = imageUrl.get_file()
		#var filePath = Mobtex.cache.cacheDir + fileName
#
		#if isForceClearCacheall:
			#if FileAccess.file_exists(filePath):
				#print("deleta cache..." + filePath)
				#DirAccess.remove_absolute(filePath)
#
		#if FileAccess.file_exists(filePath):
			#totalLoad += 1
		#else:
			#printerr("NOVA IMAGEM >>> ", url)
			#Mobtex.getHttp().baseTexture(url).download(filePath)
			#await Mobtex.getHttp().getHttpManager().completed
			#totalLoad += 1
#
		#if totalLoad == len(arrImages):
			#fn.call()
