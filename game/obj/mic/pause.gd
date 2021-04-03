extends Control


var pos = [
	"L/u/back/nodo/se1",
	"L/u/back/nodo/se2",
	"L/u/back/nodo/se3",
	"L/u/back/nodo/se4",
]#asignar los punteros
var menus = [
	"R/back/items",
	"R/back/info",
	"R/back/tlf",
]#asgnar los menus
var sel = 0#cursor es igual a 0



func _process(delta):#esta funcion se ejecuta todo el rato
	
	if visible and !$R/back.visible and !Api.get("say").isplay():#si el dialogo no esta visible y tampoco la interfaz derecha
		if Input.is_action_just_pressed("cancelar"):# al dar la tecla asignada (x)
			visible = false#cerrar el menu
			pass
		
		if Input.is_action_just_pressed("up"): #al dar la tecla asignada (arriba)
			sel -=1 #subir el cursor
			pass
		if Input.is_action_just_pressed("down"): # al dar a la tecla asignada (abajo)
			sel +=1 #bajar el cursor
			pass
		
		if sel == 4:#si el cursor esta en 3 
			sel = 0#asginarle 0
		if sel == -1:#si el cursor es -1
			sel = 3#asignarle 2
		
		$L/u/back/nodo/sec.position = get_node(pos[sel]).position # mover el cursor (alma) a la poscicion asignada
		if Input.is_action_just_released("aceptar"):#al dar la tecla asignada (z) 
			if sel == 3:
				get_tree().change_scene("res://mic/menu/main.tscn")
			else:
				for x in [0,1,2]:# ocultar todos los menus
					get_node(menus[x]).visible = false
					pass
				
				get_node(menus[sel]).visible = true # en el mismo frame mostrar el menu a abrirce
				$R/back.visible = true# mostrar el menu derecho 
			
			pass
		
		
		pass
	
	pass
	
	if $R/back.visible:
		$L/u/back/nodo/sec.visible = false
		pass
	else: 
		$L/u/back/nodo/sec.visible = true


func _on_pause_visibility_changed():#cuando se abre el menu
	
	var dat = game.player["time"]#tomar el tiempo y convertirlo de un numero de conteo a tiempo
	var hora = str(int(dat/3600)%100)#saca la hora
	var minuto = str(int((int(dat) % 3600)/(60)))# los minutos
	var segundo = str(int(dat) % 60)# y segundos
	if len(segundo) == 1:#si segundos tiene una longitud de 1 
		segundo = "0"+segundo # asignale un 0 antes
	if len(minuto) == 1: # lo mismo que segundo pero con el minuto
		minuto = "0"+minuto
	#actualizar la informacion de la caja de texto
	$L/d/back/data.text = "" + str(game.player['name']) + "\nG: " + str(game.player['coin'])+ "\n\n\n" + str(game.player['pro']) +"%\n" + str(hora) + ":" + str(minuto) + ":" + str(segundo)
	
	
	pass 
