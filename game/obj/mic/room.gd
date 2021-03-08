extends Node2D

var points = []

func _ready(): # se ejecuta al iniciar
	pass

func add_point(nombre, pos, dir=Vector2(0, 0), data={}): # añadir un punto (debe de ser un sub nodo)
	points.append({
		"name":nombre,
		"pos":pos,
		"dir":dir,
		"data":data
	})# añadir a puntos el punto de actual a la lista
	pass

func find(nombre):
	for x in points: if x["name"] == nombre: return x
	return {"name":"none","pos":Vector2(0, 0),"dir":Vector2(0, 0),"data":{}}
