extends Node2D

#res://grafica/NavsTexture/



var nav_tiro := preload("res://prefebs/Tiro_c.tscn")
var municao := 1000
var atirando := false
var tiro_t := 0.0 # tempo do tiro
var target = null

var status := ""

var horizontal_force: Vector2 = Vector2(0,0)

var start := false
var anima_fim := 0
var TEXTURAS := [
	["res://grafica/NavsTexture/"+Global.nav_select[Global.id]+"/D/","andandoD"],
	["res://grafica/NavsTexture/"+Global.nav_select[Global.id]+"/E/","andandoE"],
	["res://grafica/NavsTexture/"+Global.nav_select[Global.id]+"/morte/","morta"],
	["res://grafica/NavsTexture/"+Global.nav_select[Global.id]+"/IDLE/","parada"]
	]
var vel_limite := 1.2
export var velocidade = 600
export var coeficiente:float = 1
export var frame := 0
onready var limites_d := get_viewport().size.x/15
onready var limites_e := get_viewport().size.x - (get_viewport().size.x/15)
onready var limite_baixo :=  (get_viewport().size[1]/100)*70
var direcao := 0
export var direcaoD := 0
export var direcaoE := 0

export var esquiva = 1
var aceleration = Vector2(1,1)

export var tempo := 0.0

func _ready():
	horizontal_force = Vector2(0,0)
	$AnimatedSprite/NormalEffects.visible = false
	coeficiente = Global.allNavs[Global.nav_select[Global.id]]["coeficiente"]
	vel_limite = coeficiente+1.2
	$AnimatedSprite.frames.clear("parada")
	$AnimatedSprite.frames.clear("andandoD")
	$AnimatedSprite.frames.clear("andandoE")
	$AnimatedSprite.frames.clear("morta")
	for path in TEXTURAS:
		dir_contents(path[0],path[1])
	$AnimatedSprite.animation = "parada"
	anima_fim = int($AnimatedSprite.frames.get_frame_count("morta"))-1
	status = "ponto"


func _process(delta):
	
	if Input.is_action_pressed("ui_down"):
		atirando = true
	
	# [ PowerUp Checagem ]
	if status == "impulso":
		if $AnimatedSprite/NormalEffects.visible == false:
			coeficiente = 18
			$AnimatedSprite/Motor_direito.full("on")
		$AnimatedSprite/NormalEffects.visible = true
		Global.shake = true
	elif status == "bullet":
		atirando = true
	else:
		Global.shake = false
		atirando = false
		$AnimatedSprite/NormalEffects.visible = false
	
	frame = $AnimatedSprite.frame

	if(Global.Jogo_on == true):
		if atirando == true:
			tiro_t += delta
			if tiro_t > 0.5:
				_on_Nave_tiro()
				tiro_t = 0

		if(start == false):
			if target:
				if position.x - 20 > target.x: 
	#				direcaoE = 0
	#				direcaoD = -1
					direcao = -1
				elif position.x + 20 < target.x:
	#				direcaoE = 1
	#				direcaoD = 0
					direcao = 1
				elif position.x +20 > target.x and position.x -20 < target.x:
	#				direcaoE = 0
	#				direcaoD = 0
					direcao = 0
					$AnimatedSprite.rotation_degrees = 0

			#direcao = direcaoE+direcaoD
			if(direcao > 0 and position.x < limites_e):
				if(coeficiente > 0.8):
					coeficiente -= (coeficiente*0.4)*delta

				$AnimatedSprite.animation = "andandoD"
				$AnimatedSprite/Motor_direito.flame_fail = true
				$AnimatedSprite/Motor_direito2.flame_fail = true
				$AnimatedSprite/Motor_direito3.on_engine = false
				$AnimatedSprite/Motor_direito3.flame_fail = true
				position.x += (velocidade * delta * esquiva)*direcao

				#rotation_degrees += tempo*delta
				#if(position.y < limite_baixo):position.y += esquiva
			
			if(direcao < 0 and  position.x > limites_d):
				if(coeficiente > 1):
					coeficiente -= (coeficiente*0.4)*delta
					
				$AnimatedSprite.animation = "andandoE"
				$AnimatedSprite/Motor_direito.flame_fail = true
				$AnimatedSprite/Motor_direito2.on_engine = false
				$AnimatedSprite/Motor_direito2.flame_fail = true
				$AnimatedSprite/Motor_direito3.flame_fail = true

				
				position.x += (velocidade * delta * esquiva)*direcao
				#rotation_degrees -= tempo*delta
				#if(position.y < limite_baixo):position.y += esquiva
			
			if(direcao == 0 or position.x <= limites_d or position.x >= limites_e):
				#rotation_degrees = 0
				if coeficiente < vel_limite or coeficiente < vel_limite*1.3 and position.y <= 330:
					coeficiente += delta
				
				position.x += (velocidade*delta*esquiva)*direcao
	#			direcaoE = 0
	#			direcaoD = 0
				$AnimatedSprite.animation = "parada"
				$AnimatedSprite/Motor_direito.on_engine = true
				$AnimatedSprite/Motor_direito2.on_engine = true
				$AnimatedSprite/Motor_direito3.on_engine = true
				
				$AnimatedSprite/Motor_direito.flame_fail = false
				$AnimatedSprite/Motor_direito2.flame_fail = false
				$AnimatedSprite/Motor_direito3.flame_fail = false
				

				
				if(position.y > 800):
					#print(position)
					position.y -= 1+coeficiente
					pass
			else:
				$AnimatedSprite.rotation_degrees = getDegress(position.x)
	else:
		$AnimatedSprite.animation = "morta"


func getDegress(p):
	var sizeX = get_viewport().size.x
	var incD = 45 
	var incE = -45 
	var inclinacao = (incD - incE)/sizeX
	var nova_rotacao = incE + inclinacao * (p)
	return nova_rotacao
	

func dir_contents(path,anima):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var i = 0
		while file_name != "":
			if !dir.current_is_dir():
				var _name = String(file_name)
				if _name.find("import") != -1 and _name != ".DS_Store":
					var _path:Texture = load(path+(_name.get_slice(".", 0)+"."+_name.get_slice(".", 1)))
					$AnimatedSprite.frames.add_frame(anima,_path,i)
					i += 1
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func _on_Nave_tiro():
	#print("Tiro")
	if(Global.Jogo_on == true):
		#yield(get_tree().create_timer(0.1),"timeout")
		var TiroVai = nav_tiro.instance()
		#print($AnimatedSprite.rotation_degrees)
		TiroVai.direction = Vector2(($AnimatedSprite.rotation_degrees/30),-1)
		TiroVai.position = $AnimatedSprite/Arma_ponto.global_position
		get_parent().add_child(TiroVai)
		municao -= 1

func start_spanw_animated(pos):
	start = true
	$AnimationPlayer.get_animation("start").track_set_key_value(1, 1, coeficiente)
	var target_pos:Vector2 = Vector2(2*(get_viewport().size.x/Global.idealView.x), -193*(get_viewport().size.y/Global.idealView.y))

	$AnimationPlayer.get_animation("start").track_set_key_value(4, 1,target_pos)
	$AnimationPlayer.get_animation("start").track_set_key_value(0, 1, pos)
	$AnimationPlayer.play("start")


func set_target(event):
	if (event is InputEventScreenDrag or event is InputEventScreenTouch):
		target = event.position
		if target.x > get_viewport().size.x * Global.safeArea["max"]:
			target.x = get_viewport().size.x + 90
		elif target.x < get_viewport().size.x * Global.safeArea["min"]:
			target.x =  -90
		#print("Diferença: ", position.x - target.x)

func apply_horizontal_force(intensidade:Vector2):
	horizontal_force = intensidade

func _on_AnimationPlayer_animation_finished(anim_name):
	start = false
	$Camera2D.current = false
