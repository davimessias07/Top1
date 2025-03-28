extends Node

func save_data(endpoint:String,data:Dictionary):
	var auth = Firebase.Auth.auth
	
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(endpoint)
		var task: FirestoreTask = collection.update(auth.localid,data)

func load_data(endpoint:String):
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(endpoint)
		var task: FirestoreTask = collection.get_doc(auth.localid)
		var finished_task: FirestoreTask = await task.task_finished
		var document = finished_task.document
		
		if document && document.doc_fields:
			print("Documento >>> ",document)
		else:
			print("documento n encontrado ",finished_task.error)
