extends TextureRect


func _ready():
	Api.set("win", self)
	pass 
func getnode(nodo:String = "."):
	return get_node(nodo)

func is_visible():
	return visible

func _process(delta):
	pass
