extends Node2D

export (String) var pkg #el archivo del mundo
var data = {#data predeterminada
	"map":[],
	"name":"king none",
	"x":0,
	"y":0
}
func _ready():#se inicia
	Api.set("world", self)#se añade a la api
	var fs = File.new()
	fs.open(pkg, File.READ)
	data = JSON.parse(fs.get_as_text()).result#carga el paquete a la data
	pass
