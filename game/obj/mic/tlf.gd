extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sel = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible and !Api.get("say").isplay():
		if Input.is_action_just_pressed("menu"):
			get_parent().visible = false
			visible = false
			pass
		if Input.is_action_just_pressed("cancelar"):
			get_parent().visible = false
			visible = false
			pass
		if Input.is_action_just_pressed("up"):
			if sel == -1:
				sel = game.player["tlf"]
				pass
			pass
		if Input.is_action_just_pressed("down"):
			if sel == game.player["tlf"]+1:
				sel = 0
				pass
			pass
		get_node("sec").position = get_node("tlf" + str(sel)).position
		if Input.is_action_just_pressed("aceptar"):
				if sel == 0:
					Api.get("say").play("", game.lang["tlf"]["madre"]["di"])
					pass
				pass
		pass
	pass


func _on_tlf_visibility_changed():
	for x in range(0, $lista.get_child_count()):
		$lista.get_child(x).visible = false
		pass
	for i in range(0, game.player["tlf"]+1):
		$lista.get_child(i).visible = true
		pass
	$lista/t0.text = game.lang["tlf"]["madre"]["name"]
	
	pass # Replace with function body.
