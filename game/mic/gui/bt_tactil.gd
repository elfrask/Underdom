extends CanvasLayer


func _ready():
	$gui.position = $to.position
	if true:#OS.get_name() == "Android":
		$gui.position = Vector2()
		pass
	pass
var up = 0

func pad(d:Array=[0,0]):
	if d==[0,0]:
		print("parar")
		Input.action_release("up")
		Input.action_release("down")
		Input.action_release("left")
		Input.action_release("right")
		pass

	if d[0]>0:
		Input.action_press("right")
		pass
	elif d[0]<0:
		Input.action_press("left")
		pass
	
	if d[1]>0:
		Input.action_press("down")
		pass
	elif d[1]<0:
		Input.action_press("up")
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
		actions.position.y=280
		pass
	pad.visible = game.pad
	
	pass
