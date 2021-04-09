extends Node2D

export (String) var nombre = "main"
export (NodePath) var player
export (String) var sound = ""

func _ready():
	var pla = get_node(player)
	Api.set("room", self)
	if sound=="":
		Auda.seti("res://assets/music/menu0.ogg")
	else:
		Auda.seti("res://assets/music/" + sound + ".ogg")
		
		
	#si la escena no esta en la lista deacuerdo a su nombre entonces lo crea
	if str(game.player["story"]["room"].get(nombre, "__void__")) == "__void__":
		game.player["story"]["room"][nombre] = {
			"x":pla.position.x, #establece la posicion del personaje como posicion inicial
			"y":pla.position.y  #lo mismo de arriba pero con "Y"
		}
		pass
	
	pla.position.x = game.player["story"]["room"][nombre]["x"]#le da la posicion al personaje
	pla.position.y = game.player["story"]["room"][nombre]["y"]
	pass


func save_pos():
	var pla = get_node(player)
	
	game.player["story"]["room"][nombre]["x"]  = pla.position.x
	game.player["story"]["room"][nombre]["y"]  = pla.position.y
	game.player["story"]["location"]["room"] = nombre
	pass
	
func to_scene(s):
	var pla = get_node(player)
	
	game.player["story"]["room"][nombre]["x"]  = pla.position.x
	game.player["story"]["room"][nombre]["y"]  = pla.position.y
	game.player["story"]["location"]["room"] = nombre
	game.player["story"]["location"]["path"] = s
	
	get_tree().change_scene(s)
	pass

