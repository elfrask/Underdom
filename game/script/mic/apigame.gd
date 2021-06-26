extends Node
var lista = {}#crear una lista vacia para las Apis
func set(name = "", obj = {}):      lista[name] = obj #establecer una api
func get(name = ""):                return lista[name] #obtener una api ya guardada

func _ready(): #establece una serie de herramientas
	set("sf")

