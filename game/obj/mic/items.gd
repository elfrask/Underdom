extends Control


var vacio = "---------------------------"# establecer la prevista de slot vacio

var sel = 0# establcer cursor1 como 0
var mode = "select" #esta en el modo "select"
var set = 0# establcer cursor2 como 0

func _ready():
	visible = false
	get_parent().visible= false
	pass 

func render(i, f):
	var iterador = 0# iterador = 0
	for x in game.player["inv"].slice(i, f-1):# pasar por cada objeto del inventario deacuerdo a la posicion
		iterador =1+iterador # sumar al iterador
		if str(x) == "False": # si el objeto es igual a falso
			#print(iterador)
			get_node("lista/i" + str(iterador)).text = vacio# asignar el valor vacio
			pass
		else:# si no
			
			get_node("lista/i" + str(iterador)).text = x["nick"] # asignar el nombre del objeto
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
	
func _process(delta):
	
	if (visible and 
		!Api.get("say").isplay() and 
		!Api.get("win").is_visible()): # si el dialogo esta oculto
		
		
		if Input.is_action_just_pressed("menu"):# al dar la tecla asignada (c)
			get_parent().visible = false# ocultar el menu derecho
			visible = false#ocultar este menu
			mode = "select"# hacer que este modo se re-asigne
			pass
		$sec.visible = (mode == "select")#si modo es select el cursor1 es visible
		$gui/sec.visible = (mode == "action" or mode == "char") #si el modo es action o char entonces el cursor2 es visible
		$gui/action.visible = (mode == "action")# si el modo es action entonces el menu de acciones es visible 
		$gui/action.text = game.lang["gui"]["item"]["action"]# establecer segun el idioma el nombre de las acciones
		$gui/char.visible = (mode == "char") # si el modo es char entonces mostrar el menu de personajes
		
		if mode == "select":# si el modo es select
			
			if Input.is_action_just_pressed("cancelar"):# al dar la tecla asignada (x)
				get_parent().visible = false# ocultar el el menu derecho
				visible = false# ocultar este menu
				pass
			
			
			if Input.is_action_just_pressed("up"):# al dar la tecla asignada (arriba)
				sel -= 1# subir el cursor1
				if sel == -1:# si el cursor1 es igual a -1
					sel = len(game.player["inv"])-1# asignar el cursor1 al ultimo objeto
					pass
				pass
			if Input.is_action_just_pressed("down"):# al dar la tecla asignada (abajo)
				sel +=1# bajar el cursor1
				if sel == len(game.player["inv"]):# si esta sobre el ultimo objeto
					sel = 0# devolverlo al objeto 0 del inventario
					
					pass
				pass
			
			render(int(sel/8)*8, (int(sel/8)+1)*8)#renderizar la lista de objetos
			$page.text = str(int(sel/8)+1) + "/" + str(int(len(game.player["inv"])/8))# cambiar la pagina
			$sec.position = get_node("obj" + str(int(sel)%8)).position# cambiar la posicion del objeto
			if Input.is_action_just_pressed("aceptar"):# al dar la tecla asignada (z)
				mode = "action"# cambiar al modo action
				set = 0# establecer la poscion 0 del cursor2
				if str(game.player["inv"][sel]) == "False":# si no hay un objeto
					# Decir lo que pasa cuando el slot esta vacio
					Api.get("say").play("", game.lang["gui"]["item"]["vacio"])
					mode = "select"# devolverlo al modo select
					pass
				
				pass
			
			pass
		elif mode == "action":#modo action
			
			
			if Input.is_action_just_pressed("cancelar"):# al dar la tecla asignada (x)
				mode = "select"#devolverlo al modo select
				pass
			
			if Input.is_action_just_pressed("left"):# al dar la tecla asignada (izquierda)
				set -= 1# mover el cursor2 a la izquierda
				if set == -1:#si cursor2 esta en -1
					set = 2# moverlo a 2
					pass
				pass
			if Input.is_action_just_pressed("right"):# al dar la tecla asignada (derecha)
				set += 1# mover el cursor2 a la derecha
				if set == 3:# si cirsor2 esta en 3
					set = 0#moverlo a 0
					pass
				pass
			
			
			
			$gui/sec.position = get_node("gui/a" + str(set)).position#hacer visible la posicion del cursor2
			
			if Input.is_action_just_pressed("aceptar"):# al dar la tecla asignada (z)
			
				#si crusor2 esta:
				
				if set == 1:#si esta en 1 
					game.player["inv"][sel] = false #tirara el objeto
					mode = "select"#volver al modo select
					pass
				if set == 0:#si esta en 0
					var win = $"../../../C/win"#obtener la ventana
					var selector = $"../../../C/win/select"#obtener el modo de seleccion
					
					selector.indice = sel#establecer ese indice al selector
					selector.visible = true#renderizar el selector
					win.visible= true#y despues la ventana
					
					mode = "select"# devolver al modo select
					$gui/action.visible = false #para evitar retrasos de transicion
					#se hace ya para evitar que esto se mantenga un frame en pantalla
					$sec.visible = true
					$gui/sec.visible = false
					
					pass
				if set == 2:# si es 2
					var co = game.player["inv"][sel]
					
					# Decir informacion sobre el objeto
					Api.get("say").play("", [
						"'" + co["nick"] + "' " + game.lang["gui"]["item"]["info"][0] +" " + join(co["char"], ", "),
						game.lang["gui"]["item"]["info"][1]+"\nDef: +" + str(co["def"]) + " Atk: +" + str(co["atk"]) + " Hp: +" + str(co["hp"])
					])
					mode = "select"# volver al modo select
					pass
				
				
				pass
			
			
			
			
			pass
		elif mode == "char":# modo char
			
			
			
			
			
			
			
			
			
			
			pass
		
		pass
	pass


func _on_items_visibility_changed():# si se hace visible
	render(0,8)#renderizar el inventario
	mode = "select"# poner el modo select
	#mostrar la pagina del inventario
	$page.text = str(int(sel/8)+1) + "/" + str(int(len(game.player["inv"])/8))
	pass 
