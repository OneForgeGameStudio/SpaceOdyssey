extends Control
var Meteoro = preload("res://prefebs/Detritos.tscn")

var testeCrypt = MyCrypto.new()


func _on_Button_button_down():
	var testura:Texture = preload("res://grafica/lock.png")
	var shader = preload("res://new_shader.tres")
	$TextureRect3.material = ShaderMaterial.new()
	$TextureRect3.material.shader = shader
	$TextureRect3.material.set_shader_param("locked_icon",testura)
	

	var meteoros1 = Meteoro.instance()
	var meteoros2 = Meteoro.instance()
	#meteoros.velocidade += ($Nave.coeficiente*Global.vel)
	meteoros2.position.x = meteoros2.position.x - meteoros1.position.x
	meteoros2.tamanho = 0.5
	add_child(meteoros1)
	add_child(meteoros2)


func _on_Button2_pressed():
	$TextureRect3.material = null
	#testeCrypt.shift_data(str(),2)
	var data := {
		"dinheiro": Global.dinheiro,
		"nave": {
			"pos":{
					"x":Global.nave.pos.x,
					"y":Global.nave.pos.y,
			},
			"coeficiente": Global.nave['coeficiente'],
		},
		"nav_select": Global.nav_select,
		'id' : Global.id

	}
	
	var json_string := JSON.print(data)
	var json_string_encrypted = testeCrypt.encrypted(json_string)
	var store_data = {
		"encode":json_string_encrypted
	}
	var json_string_decrypt = testeCrypt.decrypt(json_string_encrypted)
	var my_string: Dictionary = parse_json(json_string_decrypt)
	print(my_string.nave)
	
	#{dinheiro:15, id:1, Nav_select:[Normal, Spectra], nave:{coeficiente:1.2, pos:{x:0, y:0}}}


