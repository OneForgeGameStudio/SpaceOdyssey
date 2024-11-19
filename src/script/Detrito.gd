extends "res://script/enemies/enemies_base.gd"


# Declare member variables here. Examples:
const velocidade = 80
export var tamanho = 1
const varia_MAX = 1.50
const varia_Min = 0.5
var rng = RandomNumberGenerator.new()
var posicaoInicial = 68


var roda = 0

var vida
var _name = "_detrito"




func _ready():
	modulate = Color(0.30, 0.31, 0.36)
	scale = Vector2(0.2,0.2)
	$CollisionShape2D.disabled = true
	#self.position.y = -90*idealScale.y
	rng.randomize()
	var my_random_number = rng.randf_range(-4, 4)
	var my_random_number1 = rng.randf_range(varia_Min, varia_MAX)

	tamanho = (tamanho*idealScale.x)*my_random_number1
	scale.x = tamanho
	scale.y = tamanho
#	my_random_number = rand_range(0,get_viewport().size.x*0.8)
#	position.x = posicaoInicial*idealScale.x + my_random_number
	my_random_number = rng.randf_range(-1,1)
	roda = my_random_number1*my_random_number
	#print(position, name)

func _process(delta):
	
	$Debug_m.text = str(self.position)
	area_limite(self,Vector2(220,220))
	if is_shaking:
			if position.y < 90:
				if scale.x <= 1:
					scale += Vector2((0.3*delta),(0.3*delta))
				if modulate.b <= 0.6:
					modulate += Color(0.1*delta, 0.1*delta, 0.1*delta,0)
				
				start_shake() 
			else:
				modulate = Color(1, 1, 1,1)
				is_shaking = false
				$CollisionShape2D.disabled = false
				
	if !is_shaking:
		position.y += (velocidade*delta)*(1+Global.nave.coeficiente)
		rotation_degrees += (roda+50)*delta
		rotation_degrees += (80*roda)*delta
	else:
		position.y += 100*delta



func _on_Area2D_area_entered(area):
	create_particula()
	if(area.name == "Nave"):
		if area.get_parent().status != "impulso":
			area.get_parent().coeficiente = area.get_parent().coeficiente * 0.20
			
		
	elif(area.is_in_group("Collectibles")):
		area.position += Vector2(1,1)
		position -= Vector2(1,1)
		return
	create_particula()
	queue_free()




#func new_detrito(i,delta):
#	var detrito = load("./prefebs/Meteoro.tscn")
#	var DETRITO = detrito.instance()
#	DETRITO.scale = Vector2((tamanho*0.3),(tamanho*0.3)) 
#	DETRITO.roda = (roda*-1)*delta
#	DETRITO.impacto = true
#	DETRITO.filho = true
#	DETRITO.position = self.position + Vector2(i*30,i*20)
#	DETRITO.add_to_group("Detrito")
#	get_parent().add_child(DETRITO)



func create_particula():
		var explode = load("./prefebs/explode.tscn")
		var EXPLODE = explode.instance()
		EXPLODE.position = position
		EXPLODE.scale = scale
		get_parent().add_child(EXPLODE)
