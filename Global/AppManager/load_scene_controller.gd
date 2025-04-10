extends Node

func clear(parent):
	for child in parent.get_children():
		if child:
			child.queue_free()

func trade_scene(path_scene:String,args:Dictionary = {}):
	if AppManager.current_scene == path_scene:
		printerr("Voce ja esta nessa cena")
		return
	
	var new_scene = null
	var parent_scene = AppManager.scenes
	var action_complete_trade:Callable
	
	if args.has("parent_scene"):
		parent_scene = args.parent_scene
	
	if args.has("action_complete"):
		action_complete_trade = args.action_complete
	
	if !parent_scene:
		printerr("Parent Scene Nulo")
		return
	
	if ResourceLoader.exists(path_scene):
		
		var scene = load(path_scene)
		
		if scene:
			clear(parent_scene)
			new_scene = scene.instantiate()
			parent_scene.add_child(new_scene)
			AppManager.current_scene = path_scene
		else :
			printerr("Erro ao carregar Cena")
	else:
		printerr("Cena Não Encontrada")
	
	return new_scene

func load_scene(new_scene:String,action:Callable = func ():,parent = AppManager.scenes):
	if AppManager.current_scene != new_scene:
		var scene = load(new_scene).instantiate()
		AppManager.current_scene = new_scene
		parent.add_child(scene)
		action.call()
		return scene
	else:
		printerr("Voce ja esta nessa cena")
