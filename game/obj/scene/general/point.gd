extends Position2D
export (String) var nombre = "in"
export (Lib.vista) var see

func _ready():
	game.add_point(self)
