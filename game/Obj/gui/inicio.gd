extends Node

var pha = preload("res://Obj/gui/phatom_text.tscn")

func _ready():
	$AnimationPlayer.play("init")
	$Timer.start()
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("z"): 
		get_tree().change_scene("res://Obj/game.tscn")
	pass


func _on_Timer_timeout():
	var pez = $gui/pez
	var t = pha.instance()
	var d:Label = $gui/Tfont
	
	t.rect_position = d.rect_position
	t.modulate = d.modulate
	t.get_children()[0].text = d.text	
	pez.add_child(t)
	pass 
