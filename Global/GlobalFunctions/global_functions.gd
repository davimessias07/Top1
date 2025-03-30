extends Node

func get_remote_user_attrs(action:Callable):
	var base = await AppManager.global_functions.load_data(AppManager.endpoint.USERS)
	AppManager.account_controller.json_user = base.doc_fields
	action.call()

func save_data(endpoint:String,data:Dictionary):
	var auth = Firebase.Auth.auth
	
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(endpoint)
		var task: FirestoreTask = collection.update(auth.localid,data)

func load_data(endpoint:String):
	var document = null
	var auth = Firebase.Auth.auth
	
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(endpoint)
		var task: FirestoreTask = collection.get_doc(auth.localid)
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
