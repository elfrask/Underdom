extends Node

func re_list():
	var salida = []#generar un recopilador
	var index = 0#crear una indexacion empezando de 0
	for i in game.player["char"]:#con el for recopilar los personajes
		if game.player["char"][i]["show"]:#si el personaje actual se muestra
			salida.append({
				"name":i, 
				"index":index, 
				"char":game.player["char"][i]
				})#añadirlo a la lista
			#get_node("lista/t" + str(index)).visible = true#y renderizarlo
			pass
		else:#si no
			#get_node("lista/t" + str(index)).visible = false# ocultarlo
			
			pass
		index +=1#sumarle 1 al indexador
		pass
