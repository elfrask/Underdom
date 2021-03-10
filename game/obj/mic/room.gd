extends Node2D

var points = []# generar un arreglo de puntos

func _ready(): # se ejecuta al iniciar
	pass

func add_point(nombre, pos, dir=Vector2(0, 0), data={}): # añadir un punto (debe de ser un sub nodo)
	points.append({
		"name":nombre,
		"pos":pos,
		"dir":dir,
		"data":data,
		"mapa":true
	})# añadir a puntos el punto de actual a la lista
	pass

func find(nombre):#buscar un punto segun su nombre
	for x in points: if x["name"] == nombre: return x #si la tiene entonces retornarlo
	return {"mapa":false,"name":"none","pos":Vector2(0, 0),"dir":Vector2(0, 0),"data":{}}#de lo contrario no retorne nada

