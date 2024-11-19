extends "res://script/enemies/enemies_base.gd"


var Laser = preload("res://prefebs/enemies/laser.tscn")

var asa_rotation:float = 0.0

# Animation variables 
const _maximo = 22.6 # maximo de rotação da asa
const _duration = 1
const animated_vel = 50

var _time = 0
var tiro_t = 0
signal killed(points)
#signal hit
signal enemy_attack

enum States {
	GUARDING,
	SPAW
	}

var state = States.SPAW

export var speed = 110
export var live = 1
export var min_distance_to_charge = 600
export var charge_speed = 1000
var _smoothed_charge_direction = Vector2(1,1)
var guarding_mount := 10 # Quantidade de tiros que esse estado tem
var charge_timer :float = 0.0

var _target_position = 0 #Global.nave.pos 
var crash_direction: Vector2


func _ready():
	state = States.SPAW
	blink = true

	$Asa_esquerda/Arma/EfeitoTiro.visible = false
	$Asa_direita/Arma/EfeitoTiro2.visible = false


func _process(delta):
	_target_position = get_global_mouse_position() #Global.nave.pos
	area_limite(self,Vector2(2000,2000))


	if state == States.GUARDING:
		state = _guarding_(delta)
	elif state == States.SPAW:
		state = _spaw_(delta)
		

func getDegress(time, maximo, duration):
	var deg = maximo*(cos(0.05*(time)*(PI/duration)))
	return deg


var floop_motor = false
func _motor_animated():
	var max_position = 1.2
	if floop_motor == true:
		$cabine/Motor/fuego.modulate = Color(1,1,1,0.2)
		floop_motor = false
	else:
		floop_motor = true
		$cabine/Motor/fuego.modulate = Color(1,1,1,1)
		
	$cabine/Motor.position.y = max_position * getDegress(_time, max_position, _duration) - 12
	

func _asa_animated() -> void:
	asa_rotation = getDegress(_time,_maximo,_duration)

func _move_to_target(delta,pos):
	pos =  pos + Vector2(0,-min_distance_to_charge*0.9)  
	var padding = 15
	if position.x + padding < pos.x:
		self.position.x += speed*delta
	elif position.x - padding > pos.x:
		self.position.x -= speed*delta
	if position.y + padding < pos.y:
		self.position.y += speed*delta
	elif position.y - padding > pos.y:
		self.position.y -= speed*delta

func die():
	queue_free()

func take_damage(amount):
	live -= amount
	if live <= 0:
		die()


# State machine
func _on_Nave_tiro():
	if(Global.Jogo_on == true):
		$Asa_esquerda/Arma/EfeitoTiro.visible = true
		$Asa_direita/Arma/EfeitoTiro2.visible = true
		var tiro1 = Laser.instance()
		var tiro2 = Laser.instance()
		tiro1.position = $Asa_esquerda/Arma/Position2D.global_position
		tiro2.position = $Asa_direita/Arma/Position2D2.global_position
		var direction1:Vector2 = _target_position - $Asa_esquerda/Arma/Position2D.global_position
		var direction2:Vector2 = _target_position - $Asa_direita/Arma/Position2D2.global_position
		tiro2.rotation_degrees = rad2deg(atan2(-direction2.x,-direction2.y))
		tiro1.rotation_degrees = rad2deg(atan2(-direction1.x,-direction1.y)) 
		tiro1.direction = direction1.normalized()
		tiro2.direction = direction2.normalized()
		get_parent().add_child(tiro1)
		get_parent().add_child(tiro2)
		guarding_mount -= 1
		


func _spaw_(delta):
	normal_animate(delta)
	if position.y < 60:
		position.y += delta * speed
		return States.SPAW
	if position.x < 500:
		position.x += delta * speed*1.2
		return States.SPAW
	return States.GUARDING

func _guarding_(delta):
	normal_animate(delta)
	$cabine.rotation_degrees = 0
	if guarding_mount >= 0:
		tiro_t += delta
		if tiro_t > 0.3:
			_on_Nave_tiro()
			tiro_t = 0
		elif tiro_t > 0.1:
			$Asa_esquerda/Arma/EfeitoTiro.visible = false
			$Asa_direita/Arma/EfeitoTiro2.visible = false
		return States.GUARDING
	
	return States.SPAW
func normal_animate(delta):
	_time += delta*animated_vel
	_asa_animated()
	_motor_animated()
	_smoothed_charge_direction = lerp(_target_position, _smoothed_charge_direction,0.3)
	#rotate(get_angle_to(_smoothed_charge_direction))
	
	#$cabine.rotation_degrees = rad2deg(get_angle_to(_smoothed_charge_direction)) - 90
	if abs(rad2deg(get_angle_to(_smoothed_charge_direction)) - 90) < 23:
		$Asa_esquerda/Arma.rotation_degrees = rad2deg(get_angle_to(_smoothed_charge_direction)) - 90
		$Asa_direita/Arma.rotation_degrees = rad2deg(get_angle_to(_smoothed_charge_direction)) - 90
