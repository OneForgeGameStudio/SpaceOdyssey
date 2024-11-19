extends Event

# Coin

var Coin = preload("res://prefebs/Coin.tscn")

var coinFormacao = ""
var gerarFormacao = [
	 "linha",
	 "quina",
	 "cobraX",

	]

var my_random_number = 0

var coinX = 130
const coinY = -448

var rng = RandomNumberGenerator.new()
var waiting = 20

func _ready():
	rng.randomize()
	my_random_number = rng.randi_range(0, gerarFormacao.size()-1)
	start(0.2, waiting, 'coin')


func _on_timeout():
	if live == waiting/2:
		if Global.Jogo_on == true:
			coinFormacao = gerarFormacao[my_random_number]
			if(coinFormacao == "linha"):
				coinX = 400
				for i in range(12):
					gera_Coin([coinX,coinY+(i*36)])
			elif(coinFormacao == "quina"):
				coinX = 27
				for i in range(12):
					gera_Coin([coinX+60+(i*20),coinY+(i*20)])
			elif(coinFormacao == "cobraX"):
				for i in range(12):
					coinX = sin(coinY+i + 2)*10 + 130
					gera_Coin([coinX,coinY+(i*36)])
	elif live <= 0:
		emit_signal("finsh")
		queue_free()

	live -= 1

func gera_Coin(vetor):
	var coin = Coin.instance()
	coin.position = Vector2(vetor[0],vetor[1])
	grupo.add_child(coin)


