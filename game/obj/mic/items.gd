extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var vacio = "---------------------------"

var sel = 0
var mode = "select"
var set = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func render(i, f):
	var iterador = 0
	for x in game.player["inv"].slice(i, f-1):
		iterador =1+iterador
		if str(x) == "False":
			#print(iterador)
			get_node("lista/i" + str(iterador)).text = vacio
			pass
		else:
			#print(x)
			get_node("lista/i" + str(iterador)).text = x["nick"]
			pass
		
		pass
	
	pass

func join(arr, ch):
	
	var salida = ""
	
	for x in arr:
		salida = salida + x + ch
		pass
	salida = salida.substr(0, len(salida)-len(ch))
	
	return salida
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if visible and !Api.get("say").isplay():
		if Input.is_action_just_pressed("menu"):
			get_parent().visible = false
			visible = false
			mode = "select"
			pass
		$sec.visible = (mode == "select")
		$gui/sec.visible = (mode == "action" or mode == "char")
		$gui/action.visible = (mode == "action")
		$gui/action.text = game.lang["gui"]["item"]["action"]
		$gui/char.visible = (mode == "char")
		
		if mode == "select":
			
			if Input.is_action_just_pressed("cancelar"):
				get_parent().visible = false
				visible = false
				pass
			
			
			if Input.is_action_just_pressed("up"):
				sel -= 1
				if sel == -1:
					sel = len(game.player["inv"])-1
					pass
				pass
			if Input.is_action_just_pressed("down"):
				sel +=1
				if sel == len(game.player["inv"]):
					sel = 0
					pass
				pass
			
			render(int(sel/8)*8, (int(sel/8)+1)*8)
			$page.text = str(int(sel/8)+1) + "/" + str(int(len(game.player["inv"])/8))
			$sec.position = get_node("obj" + str(int(sel)%8)).position
			if Input.is_action_just_pressed("aceptar"):
				mode = "action"
				set = 0
				if str(game.player["inv"][sel]) == "False":
					# Decir lo que pasa cuando el slot esta vacio
					Api.get("say").play("", game.lang["gui"]["item"]["vacio"])
					mode = "select"
					pass
				
				pass
			
			pass
		elif mode == "action":
			
			
			if Input.is_action_just_pressed("cancelar"):
				mode = "select"
				pass
			
			if Input.is_action_just_pressed("left"):
				set -= 1
				if set == -1:
					set = 2
					pass
				pass
			if Input.is_action_just_pressed("right"):
				set += 1
				if set == 3:
					set = 0
					pass
				pass
			
			
			
			$gui/sec.position = get_node("gui/a" + str(set)).position
			
			if Input.is_action_just_pressed("aceptar"):
			
				if set == 1:
					game.player["inv"][sel] = false
					mode = "select"
					pass
				if set == 0:
					mode = "char"
					set = 0
					pass
				if set == 2:
					var co = game.player["inv"][sel]
					
					# Decir informacion sobre el objeto
					Api.get("say").play("", [
						"'" + co["nick"] + "' " + game.lang["gui"]["item"]["info"][0] +" " + join(co["char"], ", "),
						game.lang["gui"]["item"]["info"][1]+"\nDef: +" + str(co["def"]) + " Atk: +" + str(co["atk"]) + " Hp: +" + str(co["hp"])
					])
					mode = "select"
					pass
				
				
				pass
			
			
			
			
			pass
		elif mode == "char":
			
			
			if Input.is_action_just_pressed("cancelar"):
				mode = "action"
				pass
			
			if Input.is_action_just_pressed("left"):
				set -= 1
				if set == -1:
					set = 2
					pass
				pass
			if Input.is_action_just_pressed("right"):
				set += 1
				if set == 3:
					set = 0
					pass
				pass
			
			
			
			$gui/sec.position = get_node("gui/a" + str(set)).position
			
			if Input.is_action_just_pressed("aceptar"):
				if set == 1:
					game.use("chara", sel)
					pass
				if set == 0:
					game.use("frisk", sel)
					pass
				if set == 2:
					game.use("asriel", sel)
					pass
				mode = "select"
				pass
			
			
			
			
			pass
		
		pass
	pass


func _on_items_visibility_changed():
	render(0,8)
	mode = "select"
	$page.text = str(int(sel/8)+1) + "/" + str(int(len(game.player["inv"])/8))
	pass # Replace with function body.
