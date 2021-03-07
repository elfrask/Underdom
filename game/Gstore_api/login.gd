extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var serve = ""
func verify(server):
	serve = server
	var req = $ini
	#req.download_file = server+"/active"
	var ok =req.request(server+"/active")
	visible = true
	$gui.visible =true
	if (ok != 0):
		print("llego")
		$alert/sgui.visible = true
		$alert/sgui/next.disabled = true
		$alert/Label.text = "Servidor no configurado ._."
		
		pass
	
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	var files = File.new()
	if (!files.file_exists("user://gstore.data")):
		$gui/login.visible = true
		$gui/lg.visible = false
		pass
	else:
		
		files.open("user://gstore.data", File.READ)
		Gstore.perfil= JSON.parse(files.get_as_text()).result
		
		
		$gui/lg/nombre.text = Gstore.perfil["user"]		
		$gui/login.visible = false
		$gui/lg.visible = true
		
		#cargar el archivo
		pass
	$ini.connect("request_completed", self, "_on_request_completed")
	Gstore.login(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	
	

	pass
var intentos = 0

func _on_request_completed(result, response_code, headers, body: PoolByteArray):
	#print(response_code)
	if (str(response_code) == "404"):
		print("llego")
		$alert/sgui.visible = true
		$alert/sgui/next.disabled = true
		$alert/Label.text = "Servidor no configurado ._."
		
		pass
	else:
	
		#print("salida: '" +body.get_string_from_ascii()+ "'")
		if (body.get_string_from_utf8() != "true"):
			if (intentos <5):
				intentos +=1
				$espera.start()
				pass
			else:
				var files = File.new()
				$alert/sgui.visible = true
				$alert/Label.text = "No se a podido conectar :("
				if (!files.file_exists("user://gstore.data")):
					$alert/sgui/next.disabled = true
					pass
				pass
			pass
		else:
			$alert.visible = false
			pass
		pass
		
		
		
	pass 


func _on_espera_timeout():
	var server = serve
	var req = $ini
	var ok =req.request(server+"/active")
	$espera.stop()
	pass


func _on_back_pressed():
	get_tree().quit()
	
	pass # Replace with function body.


func _on_next_pressed():
	visible = false
	if (true):
		get_tree().change_scene(Gstore.pkg["play"])
		pass
	pass 


func _on_iniciar_pressed():
	#print(Gstore.pkg)
	var k =[{
		"user":$gui/login/user.text,
		"pass":$gui/login/pass.text,
		"pkg":Gstore.pkg["name"],
	}]
	var s = $initial
	var ok = s.request(
		serve+"/verify?user=" +$gui/login/user.text + "&pass="  +$gui/login/pass.text+ "&pkg="  + Gstore.pkg["name"], 
		[],
		true,
		HTTPClient.METHOD_POST,
		JSON.print(k[0])
	)
	pass 


func _on_initial_request_completed(result, response_code, headers, body:PoolByteArray):
	
	if (response_code != 200):
		
		return null
	
	if (body.get_string_from_utf8() == "true"):
		var fs = File.new()
		Gstore.perfil = {"user":$gui/login/user.text, "pass":$gui/login/pass.text}
		fs.open("user://gstore.data", File.WRITE)
		fs.store_string(JSON.print(Gstore.perfil))
		$gui/login.visible = false
		$gui/lg.visible = true
		$gui/lg/nombre.text = Gstore.perfil["user"]
		pass
	else:
		$gui/no.visible = true
		$gui/login/user.text = ""
		$gui/login/pass.text = ""
		pass
	
	pass 


func _on_restart_pressed():
	$gui/no.visible = false
	$gui/login/user.text = ""
	$gui/login/pass.text = ""
	$gui/login.visible = true
	$gui/lg.visible = false
	pass # Replace with function body.


func _on_logout_pressed():
	var fs = File.new()
	if (fs.file_exists("user://gstore.data")):
		Directory.new().remove("user://gstore.data")
		pass
	Gstore.perfil = {"name":"", "pass":""}
	$gui/login.visible = true
	$gui/lg.visible = false
	pass 





func _on_start_pressed():
	visible = false
	if (true):
		get_tree().change_scene(Gstore.pkg["play"])
		pass
	pass # Replace with function body.
