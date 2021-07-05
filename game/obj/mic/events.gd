extends Node

var data = {}

func _ready():
	var d:Array =get_children()
	for i in d:
		data[i.name] = i
		pass
	pass
