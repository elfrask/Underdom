extends Area2D
export (String) var to_scene #pon la ruta de la scena aqui


var disa = true #sera disa al iniciar
var trasport=false
var wait = false

func _ready(): #se ejecuta al iniciar
	$Timer.connect("timeout", self, "fin")
	$Timer.start()
	pass 
func _process(delta): #se ejecuta a cada rato
	if wait:
		if disa: #se ejecuta al inicio
			var hay=false #por defecto hay sera falso
			for i in (get_overlapping_bodies()): #cargar los nodos con los que coliciona
				if i.is_in_group("player"): #y determinar si esta en el grupo del jugador
					hay = true #si lo esta hacer que hay sea verdadero
					
					pass
				
				pass
			disa = hay#si el personaje no esta dentro del area entonces
			#que se desactive disa
			pass
		else:#si disa esta desactivado
			for i in (get_overlapping_bodies()):#leer todos los nodos con los que colisiona
				if i.is_in_group("player"):#si el jugador esta en el area
					#entonces que cambie de escena
					trasport = true
					Api.get("trans").black()
					
					pass
				
				pass
			
			pass
		pass
	if trasport and !Api.get("trans").get_see_invert():
		print(to_scene)
		Api.get("room").to_scene(to_scene)
		
		pass
	pass
func fin():
	wait = true
	$Timer.stop()
	pass
