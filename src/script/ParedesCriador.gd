extends Node2D

var velocidade = 200
var rng = RandomNumberGenerator.new()
var gira =0
var aceleracao = 1
var _name = "parede"
func _ready():
	position.y = - 140*(1+Global.nave.coeficiente)
	rng.randomize()
	var my_random_numberE = rng.randf_range(-55,23)
	var my_random_numberD = rng.randf_range(500,625)
	gira = rng.randf_range(0.1,-0.1)
	$AnimationPlayer.get_animation("crash").track_set_key_value(1, 2, Vector2(my_random_numberD,self.position.y+4))
	$AnimationPlayer.get_animation("crash").track_set_key_value(0, 2, Vector2(my_random_numberE,self.position.y+4))
	$AnimationPlayer.play("crash")

	$Colide_D.position.x = my_random_numberD
	$Colide_E.position.x = my_random_numberE






func _process(delta):
	aceleracao += delta
	if(Global.Jogo_on == true):
		position.y += ((velocidade * aceleracao)*delta)*(1+Global.nave.coeficiente)
		rotation_degrees += gira
	if(position.y > 2200):
		queue_free()


func _on_Colide_D_area_entered(area):
	if(area.name == "Nave"):
		dano(area)


func _on_Colide_E_area_entered(area):
	if(area.name == "Nave"):
		dano(area)


func dano(area):
	Global.Jogo_on = false
	var dano = Sprite.new()
	var danoTexture: Texture = load("res://grafica/Eventos/momentum/impacto_effect.png")
	dano.name = "dano"
	dano.position = (area.get_parent().position-position) + Vector2(6,-20)
	dano.visible = true
	dano.texture = danoTexture
	dano.centered = true
	add_child(dano)
	
