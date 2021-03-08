extends Node

var server = "http://localhost:8080"
var perfil = {
	"user":"",
	"pass":""
}
var pkg = {
	"name":"app.test.gstore",
	"ver":"1.0",
	"key":"xxxx-xxxx-xxxx-xxxx",
	"play":"res://game.tscn"
}
var logi = null
func login(v):
	logi = v
	v.visible = false
	v.verify(server)
	pass
func _ready():
	var vs = File.new()
	if (vs.file_exists("res://app.json")):
		vs.open("res://app.json", File.READ)
		
		pkg = JSON.parse(vs.get_as_text()).result
		pass
	pass

func _process(delta):
	if logi != null:
		
		
		pass
	pass
