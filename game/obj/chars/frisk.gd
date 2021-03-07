extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var vel = 100



var y_l = 0
var ismove = false
var ray_distant =15



# Called when the node enters the scene tree for the first time.
func _ready():
	var vis = $v/visual
	y_l = vis.position.y
	pass # Replace with function body.


func vs(ani):
	var vis = $v/visual
	
	if true:
		vis.play(ani)
		pass
	
	pass


func moving(dir):
	var vis = $v/visual
	
	if dir.x == 0 and dir.y == 0:
		vis.stop()
		vis.frame = 0
		vis.animation = "none"
		
		pass
	if dir.x == 0:
		
		if dir.y > 0:
			vs("abajo")
			$cast.cast_to = Vector2(0, 1*ray_distant)
			pass
		elif dir.y < 0:
			vs("arriba")
			$cast.cast_to = Vector2(0, -1*ray_distant)
			pass
		pass
	if dir.y == 0:
		if dir.x > 0:
			
			$cast.cast_to = Vector2(1*ray_distant, 0)
			vs("derecha")
			pass
		elif dir.x < 0:
			
			$cast.cast_to = Vector2(-1*ray_distant, 0)
			vs("izquierda")
			pass
		pass	
	
	
	pass

func _physics_process(delta):
	
	if !$camara/menu.visible and !$camara/dbox.visible:
		_move(delta)
		pass
	elif $camara/menu.visible and !$camara/dbox.visible:
		if Input.is_action_just_pressed("menu"):
			$camara/menu.visible = false
			pass
		pass
	
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _move(delta):
	
	var vis = $v/visual
	
	var dir = Vector2()
	if vis.frame == 1 or vis.frame == 3:
		vis.position.y = y_l +1
		pass
	else:
		vis.position.y = y_l
		pass
	dir.y = int(Input.is_action_pressed("down"))-int(Input.is_action_pressed("up"))
	dir.x = int(Input.is_action_pressed("right"))-int(Input.is_action_pressed("left"))
	moving(dir)
	
	if Input.is_action_just_pressed("aceptar"): # al dar z
		if $cast.is_colliding():
			var obj = $cast.get_collider()
			if obj.is_in_group("say"):
				var data = obj.say()
				Api.get("say").play(data[0], data[1]) # data 0 el nombre y en 1 los dialogos
				pass
			pass
		pass
	
	dir*=vel
	move_and_slide(dir)
	
	if Input.is_action_just_pressed("menu"): # al da c
		$camara/menu.visible = true
		vis.stop()
		vis.frame = 0
		vis.position.y = y_l
		#vis.position.y = 0
		pass
	
	
	pass


func _on_Timer_timeout():
	if !$camara/menu.visible:
		game.player["time"] +=1
		pass
	pass # Replace with function body.
