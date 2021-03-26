extends Node
var lista = {}#crear una lista vacia para las Apis
func get(name = ""):                return lista[name] #obtener una api ya guardada
func set(name = "", obj = {}):      lista[name] = obj #establecer una api

func _ready(): #establece una serie de herramientas
	set("sf")

