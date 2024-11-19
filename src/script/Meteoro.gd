extends "res://script/enemies/enemies_base.gd"


# Declare member variables here. Examples:
export var velocidade = 130
export var tamanho = 1
const varia_MAX = 1.0
const varia_Min = 0.5
var rng = RandomNumberGenerator.new()
var posicaoInicial = 68
var impacto = false
var roda = 0
var meteoroVida = 10
var filho = false
var vida
var _name = "mete"
onready var vida_ = [
	load("./grafica/Eventos/CometaExplode/cometa_dan01.png"),
	load("./grafica/Eventos/CometaExplode/cometa_dan02.png")
]

var deformacao =0

func _ready():
	Global.scaleMeteoro = get_children()[0].texture.get_size()
	if filho != true:
		$Cometa.modulate = Color(0.30, 0.31, 0.36)
		$Cometa.scale = Vector2(0.2,0.2)
		$CollisionShape2D.disabled = true
		self.position.y = -160
		rng.randomize()
		var my_random_number = rng.randf_range(1, 4)
		var my_random_number1 = rng.randf_range(varia_Min, varia_MAX)
		velocidade = velocidade*my_random_number
		tamanho = tamanho*my_random_number1
		scale.x = tamanho
		scale.y = tamanho
		my_random_number = rand_range(0,get_viewport().size.x*0.8)
		position.x = posicaoInicial*idealScale.x + my_random_number
		my_random_number = rng.randf_range(-1,1)
		roda = my_random_number1*my_random_number

	Global.velMeteoro = velocidade
	if(tamanho < 0.8):
		meteoroVida = 3
		vida = meteoroVida
	else:
		meteoroVida = 2
		vida = meteoroVida
	scale = idealScale

func _process(delta):
	$Debug_m.text = str(self.position)
	area_limite(self,Vector2(220,220))
	
	if(meteoroVida <= 0): #scale.x < 0.4
		create_particula()
		if (scale.x > 0.5):
			if (tamanho > 1.3):
				for i in range(3):
					new_detrito(i,delta)
					
			else:
				new_detrito(0,delta)
		queue_free()
	if is_shaking:
			if $Cometa.scale.x <= 1.0:
				$Cometa.scale += Vector2((0.3*delta),(0.3*delta))
				$Cometa.modulate += Color(0.1*delta, 0.1*delta, 0.1*delta,0)
				#print($Cometa.modulate)
				start_shake() 
			else:
				$Cometa.modulate = Color(1, 1, 1,1)
				is_shaking = false
				$CollisionShape2D.disabled = false
				
	if(impacto == true):
		if(deformacao < 1):
			position.y += (velocidade*delta)*(1+Global.nave.coeficiente)
			position.x -= (velocidade + 2)*delta
			rotation_degrees -= (roda + 80)*delta
		elif(deformacao > 1):
			position.x += velocidade*delta
			position.y += ((velocidade + 2)*delta)*(1+Global.nave.coeficiente)
			rotation_degrees += (roda + 80)*delta
	else:
		if !is_shaking:
			position.y += (velocidade*delta)*(1+Global.nave.coeficiente)
			rotation_degrees += (roda+50)*delta
			rotation_degrees += (80*roda)*delta
		else:
			position.y += 100*delta
	if (meteoroVida*100)/vida <= 90 and (meteoroVida*100)/vida >= 75:
		$Cometa.texture = vida_[0]


	elif (meteoroVida*100)/vida <= 50:
		$Cometa.texture = vida_[1]
		



func _on_Area2D_area_entered(area):
	create_particula()
	if(area.name == "Nave"):
		if area.get_parent().status != "impulso":
			Global.Jogo_on = false
			impacto = true
			
			deformacao = position.x - area.position.x
			
			velocidade = velocidade * 0.20

		meteoroVida = meteoroVida*0.2
			
	elif(area.is_in_group("Projectiles")):
		meteoroVida -= area.power
	elif(area.is_in_group("Detrito")):
		
		meteoroVida -= 1
		impacto = true
		deformacao = position.x - area.position.x
		return
	elif(area.is_in_group("Enemies")):
		impacto = true
		deformacao = position.x - area.position.x
		meteoroVida = 0
		
	elif(area.is_in_group("Collectibles")):
		area.position += Vector2(1,1)
	else:
		#print("Vascu")
		pass




func new_detrito(i,delta):
	var detrito = load("./prefebs/Meteoro.tscn")
	var DETRITO = detrito.instance()
	DETRITO.scale = Vector2((tamanho*0.3),(tamanho*0.3)) 
	DETRITO.roda = (roda*-1)*delta
	DETRITO.impacto = true
	DETRITO.filho = true
	DETRITO.position = self.position + Vector2(i*30,i*20)
	DETRITO.add_to_group("Detrito")
	get_parent().add_child(DETRITO)



func create_particula():
		var explode = load("./prefebs/explode.tscn")
		var EXPLODE = explode.instance()
		EXPLODE.position = position
		EXPLODE.scale = scale
		get_parent().add_child(EXPLODE)
