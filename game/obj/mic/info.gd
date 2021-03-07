extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if visible:
		
		if Input.is_action_just_pressed("cancelar"):
			get_parent().visible = false
			visible = false
			pass
		if Input.is_action_just_pressed("menu"):
			get_parent().visible = false
			visible = false
			pass
		
		
		pass

	pass


func _on_info_visibility_changed():
	$frisk.text = "Frisk\nlv " + str(game.player["char"]["frisk"]['lv'])+ "/50\n("+ str(game.player["char"]["frisk"]['lvup']) +")\nDef: " + str(int(game.player["char"]["frisk"]['def'])+ int(game.player["char"]["frisk"]['armor'].get("def", 0))) +"\nAtk: " + str(int(game.player["char"]["frisk"]['atk'])+ int(game.player["char"]["frisk"]['hit'].get("atk", 0))) + "\nHp: " + str(game.hp["frisk"])+"\nPE: " + str(game.player["char"]["frisk"]['pe'])
	$chara.text = "Chara\nlv " + str(game.player["char"]["chara"]['lv'])+ "/50\n("+ str(game.player["char"]["chara"]['lvup']) +")\nDef: " + str(int(game.player["char"]["chara"]['def'])+ int(game.player["char"]["chara"]['armor'].get("def", 0))) +"\nAtk: " + str(int(game.player["char"]["chara"]['atk'])+ int(game.player["char"]["chara"]['hit'].get("atk", 0))) + "\nHp: " + str(game.hp["chara"])+"\nPE: " + str(game.player["char"]["chara"]['pe'])
	$asriel.text = "Asriel\nlv " + str(game.player["char"]["asriel"]['lv'])+ "/50\n("+ str(game.player["char"]["asriel"]['lvup']) +")\nDef: " + str(int(game.player["char"]["asriel"]['def'])+ int(game.player["char"]["asriel"]['armor'].get("def", 0))) +"\nAtk: " + str(int(game.player["char"]["asriel"]['atk'])+ int(game.player["char"]["asriel"]['hit'].get("atk", 0))) + "\nHp: " + str(game.hp["asriel"])+"\nPE: " + str(game.player["char"]["asriel"]['pe'])
	
	pass # Replace with function body.
