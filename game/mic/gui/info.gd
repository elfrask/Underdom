extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_info_visibility_changed():
	$r/data.text = "" + str(game.player['name']) + "\nlv " + str(game.player['lv'])+ "/50\n\nDef: " + str(game.player['def']) +"\nAtk: " + str(game.player['atk']) + "\nHp: " + str(game.vida)
	
	pass # Replace with function body.
