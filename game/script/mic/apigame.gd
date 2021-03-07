extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lista = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get(name = ""):                return lista[name]
func set(name = "", obj = {}):      lista[name] = obj


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
