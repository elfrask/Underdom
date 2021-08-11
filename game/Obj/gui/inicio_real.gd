extends Node


func _ready():
	$ani.play("ini")
func _process(delta):
	if $gui/info.visible:
		if Input.is_action_just_pressed("x"):
			$gui/info.visible = false
			$gui/options.visible = true
