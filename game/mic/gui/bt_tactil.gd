extends CanvasLayer



func start():
	game.gamepad = false
	if OS.get_name() == "Android":
		game.gamepad = true
		pass
	pass

func _ready():
	$hide.visible = true


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
		actions.position.y=200
		pass
	pad.visible = game.pad
	$gui.visible = game.gamepad
	
	
	pass


func _on_hide_pressed():
	game.gamepad = !game.gamepad
	pass # Replace with function body.
