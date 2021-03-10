extends Node2D

export (String) var pkg 
var data = {
	"map":[],
	"name":"king none",
	"x":0,
	"y":0
}
func _ready():
	Api.set("world", self)
	var fs = File.new()
	fs.open(pkg, File.READ)
	data = JSON.parse(fs.get_as_text())
	pass
