extends Control

var indice =0
var sec= 0
var maxsel = 0
var chars = []
var protect = true

func _ready():
	visible = false
	
	pass

func _process(delta):
	
	if visible and !Api.get("say").isplay():
		
		if Input.is_action_just_pressed("menu"):# al dar a la tecla asignada (c)
			get_parent().visible = false# cerrar el menu derecho
			visible = false#cerrar este menu
			pass
		if Input.is_action_just_pressed("cancelar"):# al dar a la tecla asignada (x)
			get_parent().visible = false# cerrar el menu derecho
			visible = false#cerrar este menu
			pass
		if Input.is_action_just_pressed("up"):# al dar a la tecla asignada (arriba)
			sec -=1
			if sec == -1:# si el cursor esta en -1
				sec = maxsel # moverlo al ultimo disponible
				pass
			pass
		if Input.is_action_just_pressed("down"):# al dar a la tecla asignada (abajo)
			sec +=1
			if sec == maxsel:#si el cursor esta en el ultimo disponeble
				sec = 0# establecerlo en 0
				pass
			pass
		get_node("sec").position = get_node("char" + str(sec)).position
		if Input.is_action_just_pressed("aceptar"):# al dar la tecla asignada (z)
				#si el cursor uno esta en:
				if !protect:
					game.use(chars[sec]["name"], indice)
					visible = false
					get_parent().visible = false
				else:
					protect = false
		pass
	else:
		protect = true
		pass
	pass

func _on_select_visibility_changed():
	#print("renderiza")
	var salida = []#generar un recopilador
	var index = 0#crear una indexacion empezando de 0
	for i in game.player["char"]:#con el for recopilar los personajes
		if game.player["char"][i]["show"]:#si el personaje actual se muestra
			salida.append({
				"name":i, 
				"index":index, 
				"char":game.player["char"][i]
				})#añadirlo a la lista
			get_node("lista/t" + str(index)).visible = true#y renderizarlo
			pass
		else:#si no
			get_node("lista/t" + str(index)).visible = false# ocultarlo
			
			pass
		index +=1#sumarle 1 al indexador
		pass
	maxsel = len(salida)#sacar la longitud de la recopilacion
	chars = salida#poner en chars los recopilado
	#print(maxsel)
	
	pass 


