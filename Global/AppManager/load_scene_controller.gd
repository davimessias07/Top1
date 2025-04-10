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
	var action_complete_trade:Dictionary = {}
	
	if args.has("parent_scene"):
		parent_scene = args.parent_scene
	
	if args.has("action_complete"):
		if typeof(args.action_complete) == TYPE_DICTIONARY:
			action_complete_trade = args.action_complete
		else :
			printerr("Tipo incorreto do action_complete")
	
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
			
			if  args.has("action_complete") and action_complete_trade != {}:
				
				if action_complete_trade.has("action"):
					var action = action_complete_trade.action
					var callable = null
					
					if typeof(action) == TYPE_STRING:
						if new_scene.has_method(action):
							callable = Callable(new_scene,action)
					elif typeof(action) == TYPE_CALLABLE:
						if action.is_valid():
							callable = action
						else:
							printerr("action invalido")
							return
					
					if callable:
						if callable.is_valid():
							if action_complete_trade.has("action_args"):
								callable.call(action_complete_trade.action_args)
							else:
								callable.call()
			else:
				printerr("action_complete_trade em Branco")
				
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
