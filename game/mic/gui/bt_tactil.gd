extends CanvasLayer


func _ready():
	$gui.visible = false
	if OS.get_name() == "Android":
		$gui.visible = true
		pass
	pass

func _process(delta):
	
	var pad = $gui/move
	var show = $gui/moveshow
	var actions = $gui/actions
	
	if Input.is_action_just_pressed("show"):
		game.pad = !game.pad
	
	if game.pad:
		actions.position.y=360
		pass
	else:
		actions.position.y=240
		pass
	pad.visible = game.pad
	
	pass


func _on_hide_pressed():
	$gui.visible = !$gui.visible
	pass # Replace with function body.
