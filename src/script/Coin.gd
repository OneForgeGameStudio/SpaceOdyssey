extends "res://script/coletavel.gd"

export var balaVel = 100
signal bateu
var bateu := false
export var rodaNormal = 1
var impacto = 0
var desloca = 0
var a := 1.0

var _name := "coin"

var tempo:float = 0

func _process(delta):
	area_limite($CoinCollision,Vector2(90,0))
		
	rotation_degrees += rodaNormal
	if bateu == true:
		if position.x < (get_viewport().size.x - 90):
			position.x += 3*(3+delta)
		if position.x > (get_viewport().size.x - 90) and position.y > 4*(get_viewport().size.y/100):
			position.x -= 3*(3+delta)
		if position.y > 10*(get_viewport().size.y/100):
			position.y -= 3*(3+delta)
		elif position.y <= get_viewport().size.y - ((get_viewport().size.y/100)*90):
			queue_free()
		if position.y > 25*(get_viewport().size.y/100) and position.y < 300*(get_viewport().size.y/100):
			tempo += delta
			if(tempo > 0.6):
				$AudioStreamPlayer.volume_db -= 10
				#print(tempo)
			a -= 0.01
			self.modulate = Color(1, 1, 1, a)
			self.scale.x -= 0.01
			self.scale.y -= 0.01


	elif (Global.Jogo_on == true):
		if Global.go == false:
			if (impacto != 0 and bateu != true):
				position.x += 1*(1+delta)
				position.y += ((balaVel+impacto)*delta)+Global.nave.coeficiente
			elif bateu != true:
				position.y += ((balaVel+impacto)*delta)+Global.nave.coeficiente
				rotation_degrees += rodaNormal
		else:
			if position.x < Global.nave["pos"].x and position.y > Global.nave["pos"].y:
				position.x += 3*(3+delta)
				position.y -= 3*(3+delta)
			if position.x < Global.nave["pos"].x and position.y < Global.nave["pos"].y:
				position.y += 3*(3+delta)
				position.x += 3*(3+delta)
			if position.x > Global.nave["pos"].x and position.y < Global.nave["pos"].y:
				position.y += 3*(3+delta)
				position.x -= 3*(3+delta)
			if position.x > Global.nave["pos"].x and position.y > Global.nave["pos"].y:
				position.x -= 3*(3+delta)
				position.y -= 3*(3+delta)



func _on_Coin_bateu():
	$AudioStreamPlayer.playing = true
	$CoinCollision.set_deferred("disabled", true)
	Global.dinheiro +=1
	get_parent().emit_signal("coin_anime")
	bateu = true
	


func _on_Coin_area_entered(area):
	impacto += -(area.position.y)
	if(area.name == "Nave" ):
		emit_signal("bateu")
		
	elif area.is_in_group("Meteoro"):
		desloca = Global.scaleMeteoro*(128/2)
		rodaNormal += area.rotation_degrees
		impacto = Global.velMeteoro


