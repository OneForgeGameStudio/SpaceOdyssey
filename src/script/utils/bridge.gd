extends Object

var gtway = "https://api.loja.com.br"
var path = "res://saves/"
var store_navs_path = "res://grafica/Shopping/navs"
var navs_path 'res://grafica/NavsTexture'


func _init():
	var req = HTTPRequest.new()
	req.connect("request_completed", self, "_on_request_completed")
	add_child(req)
	loadConfiguration()

func loadConfiguration():
	OS.get_unique_id()  #Gera um ID aleatório para cada vez que jogo é baixado.
	OS.set_window_fullscreen(true)

	
	

func alertUser(notification:String):
	OS.alert(notification)

#ID_client


# Precisar ter SET e GET para controle de atribuições.


#Rostas -> Gatway
#Json {
#       Valores e Produtos da loja     }


#check_fraude()
#shop_update() / dia
#events_update() / mês
#get_data()


func get_data():
	var url = gtway + "/get_data"
	req.request(url)
	
	

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse(body)
		print(json)
	else:
		print("Erro ao conectar com o servidor")
		print(response_code)
		print(body)
		print(headers)