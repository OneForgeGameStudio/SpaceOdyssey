class_name SaveGame
extends Reference

const SAVE_GAME_PATH := "res://saves/save.json"

var _file := File.new()
var _crypt = MyCrypto.new() 


func save_exists() -> bool:
	return _file.file_exists(SAVE_GAME_PATH)
	

func write_savegame() -> void:
	var error := _file.open(SAVE_GAME_PATH, File.WRITE)
	if error != OK:
		printerr("WRITE_GAME Erro ao acessar o %s, \n erro: %s" % [SAVE_GAME_PATH, error])
		return
	
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
	var json_string_encrypted = _crypt.encrypted(json_string)
	
	var store_data = {
		"encode":Array(json_string_encrypted)
	}
	var store_data_json_string := JSON.print(store_data)
	_file.store_string(store_data_json_string)
	_file.close()

func load_savegame():
	
	var error := _file.open(SAVE_GAME_PATH, File.READ)
	if error != OK:
		printerr("LOAD_GAME - Erro ao acessar o %s, \n erro: %s" % [SAVE_GAME_PATH, error])
		return
	var content = _file.get_as_text()
	_file.close()
	#print("conteudo: ", content)
	var encode: Dictionary = parse_json(content)
	var json_string_decrypt = _crypt.decrypt(PoolByteArray(encode.encode))
	#print("Sem cripto: ", json_string_decrypt)
	if json_string_decrypt == "ERROR":
		print("Erro ao descriptografar")
		return
	var data: Dictionary = parse_json(json_string_decrypt)
	Global.dinheiro = data.dinheiro
	Global.id = data.id
	Global.nav_select = data.nav_select

	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

