extends Position2D

export (String) var nombre = ""         # asignar un nombre unico al punto
export (Vector2) var dir = Vector2(0, 0)# asignar una direccion a la cual mirar
export (Dictionary) var data = {}       # asignar una data adicional

func _ready():
	get_parent().add_point(nombre, position, dir, data) # añadirce al escenario
	pass
