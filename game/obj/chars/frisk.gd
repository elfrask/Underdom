extends KinematicBody2D


export (int) var vel = 100 #exportar la velocidad para su modificacion simple

var y_l = 0 #establecer "Y" de el sprite para simular movimiento al caminar
var ismove = false #si se esta moviendo = falso
var ray_distant =15 #distancia del rayo en busca de un objeto
export (int) var see= 2 #0 arriba, 1 derecha, 2 abajo, 3 izquierda
var array_see = ["arriba", "derecha", "abajo", "izquierda"] #arreglo de posiciones
var on_wall = false # e el muro?
func _ready(): #esta funcion se ejecuta al inicio
	#print("crear personaje")
	var vis = $v/visual #captura el sprite
	y_l = vis.position.y #asignar el valor de este
	vis.play(array_see[see])
	vis.stop()
	vis.frame = 0
	$camara/transition.white()
	pass 

func vs(ani): #vs visual start, iniciar la animacion pasada por el argumento ani
	var vis = $v/visual#capturar el sprite
	
	if true:
		vis.play(ani)#ejecutar la animacion
		pass
	
	pass

func moving(dir): #esta funcion se llama cuando se esta moviendo
	var vis = $v/visual
	
	if !on_wall:
		
		if dir.x == 0 and dir.y == 0:# si no se esta moviendo
			vis.stop() #detener la animacion
			vis.frame = 0 #asignar el fotograma cero de la animacion
			#vis.animation = "none" #asignar una animacion nula
			
			pass
		if dir.x == 0: #si el movimiento X es igual a 0
			
			if dir.y > 0: #si Y es mayor a 0
				vs("abajo")#asignamos la animacion de bajar
				see = 2
				$cast.cast_to = Vector2(0, 1*ray_distant)#cambiar la direccion del rayo a vertical
				pass
				
			elif dir.y < 0:#si es menor a 0, lo mismo que el de arriba pero el rayo al otro lado
				see = 0
				vs("arriba")
				$cast.cast_to = Vector2(0, -1*ray_distant)
				pass
				
			pass
		if dir.y == 0: # si "Y" es 0
			if dir.x > 0:# si X es mayor a 0
				
				$cast.cast_to = Vector2(1*ray_distant, 0)# asignar una orientacion horizontal al rayo
				vs("derecha") # asginar una animacion a la derecha
				see = 1
				
				pass
			elif dir.x < 0:# si es menor a 0, lo mismo de arriba pero al revez
				
				$cast.cast_to = Vector2(-1*ray_distant, 0)
				vs("izquierda")
				see = 3
				
				pass
			pass	
		pass
	else:
		vis.stop() #detener la animacion
		vis.frame = 0 #asignar el fotograma cero de la animacion
		#vis.animation = "none" #asignar una animacion nula
		
		pass
	
	pass

func _physics_process(delta): #esta funcion se actualiza todo el rato
	
	if !$camara/menu.visible and !$camara/dbox.visible and !Api.get("trans").get_see():# si el menu y el dialogo no estan visibles
		_move(delta)# dejar que el jugador haga los movimientos normales
		pass
	elif $camara/menu.visible and !$camara/dbox.visible:# pero si el menu es visible
		
		if Input.is_action_just_pressed("menu"): #al precionar la tecla asignada (c) 
			$camara/menu.visible = false #se cerrara el menu
			pass
		pass
	else:
		$v/visual.stop()
		$v/visual.frame= 0
		pass
	
	
	pass

func _move(delta): #esta funcion se encarga de dar la meccanica RPG
	
	var vis = $v/visual#capturar el sprite
	
	var dir = Vector2()# asignar que la direccion sera (x=0, y=0)
	if vis.frame == 1 or vis.frame == 3:#si la aniacion actual esta en el fotograma 1 o 3
		vis.position.y = y_l +1# porner el sprite un pixel mas abajo
		pass
	else:# si no
		vis.position.y = y_l# ponerlo en su posicion original
		pass
	#capturar la direccion Y segun las teclas asignadas
	dir.y = int(Input.is_action_pressed("down"))-int(Input.is_action_pressed("up"))
	#capturar la direccion X segun las teclas asignadas
	dir.x = int(Input.is_action_pressed("right"))-int(Input.is_action_pressed("left"))
	moving(dir) #darle animacion y determinar si se esta moviendo o no
	
	if Input.is_action_just_pressed("aceptar"): #al dar la tecla asignada (z)
		if $cast.is_colliding(): #si el rayo esta capturando un objeto
			var obj = $cast.get_collider() #obtener el objeto
			if obj.is_in_group("say"): #verificar si pertenece al grupo de "say"
				var data = obj.say() #obtener lo que quiere decir
				Api.get("say").play(data[0], data[1], data[2], data[3]) #evia a la api del dialogo data 0 el nombre y en 1 los dialogos
				pass
			pass
		pass
	
	dir*=vel#asignar la velocidad al personaje
	var wally =move_and_slide(dir, Vector2(0, 0))#mover el personaje
	"""if is_on_wall():
		if wally.x == 0:
			if wally.y == 0:
				on_wall = true
				pass
			else: 
				on_wall = false
				pass
			pass
		else:
			on_wall = false
		pass
	else:
		on_wall = false"""
			
	if Input.is_action_just_pressed("menu"): # al dar la tecla asignada (c)
		$camara/menu.visible = true #abrir el menu
		vis.stop()#parar la animacion
		vis.frame = 0#asignar el fotograma 0 de la animacion actual
		vis.position.y = y_l#devolver el sprite a su sitio
		pass
	
	
	pass

func _on_Timer_timeout(): #cada segundo
	if !$camara/menu.visible: # si el menu no esta abierto
		game.player["time"] +=1 # sumarle un segundo al tiempo de la partida
		pass
	pass 

"""if is_on_wall():
		if !(dir.x == 0 and dir.y == 0):#si se esta moviendo
			if (wally.x != 0 or wally.y != 0): #y el resultado es moviendo se
				on_wall = true#esta en el muro
				pass
			else:
				on_wall = false#sino no
				
				pass
			pass
		else:
			on_wall = false#sino no
			
			pass
	else:
		on_wall = true#sino no
		
		pass"""
