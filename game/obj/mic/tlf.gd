extends Control


var sel = 0# establecer el cursor en 0



func _process(delta):
	if visible and !Api.get("say").isplay(): # si el dialogo no es visible
		if Input.is_action_just_pressed("menu"):# al dar a la tecla asignada (c)
			get_parent().visible = false# cerrar el menu derecho
			visible = false#cerrar este menu
			pass
		if Input.is_action_just_pressed("cancelar"):# al dar a la tecla asignada (x)
			get_parent().visible = false# cerrar el menu derecho
			visible = false#cerrar este menu
			pass
		if Input.is_action_just_pressed("up"):# al dar a la tecla asignada (arriba)
			if sel == -1:# si el cursor esta en -1
				sel = game.player["tlf"] # moverlo al ultimo disponible
				pass
			pass
		if Input.is_action_just_pressed("down"):# al dar a la tecla asignada (abajo)
			if sel == game.player["tlf"]+1:#si el cursor esta en el ultimo disponeble
				sel = 0# establecerlo en 0
				pass
			pass
		get_node("sec").position = get_node("tlf" + str(sel)).position
		if Input.is_action_just_pressed("aceptar"):# al dar a la tecla asignada (z)
				if sel == 0:# comunicarce con mama
					Api.get("say").play("", game.lang["tlf"]["madre"]["di"]) #dar un dialogo segun el idioma configurado
					pass
				pass
		pass
	pass


func _on_tlf_visibility_changed():
	for x in range(0, $lista.get_child_count()):
		$lista.get_child(x).visible = false
		pass
	for i in range(0, game.player["tlf"]+1):
		$lista.get_child(i).visible = true
		pass
	$lista/t0.text = game.lang["tlf"]["madre"]["name"]
	
	pass # Replace with function body.
