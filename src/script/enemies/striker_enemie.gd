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
	GO_TO, 
	GUARDING,
	CHARGING,
	CRASH,
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
	$Asa_esquerda/lamina.rotation = 0
	$Asa_direita/lamina.rotation = 0
	$EfeitoTiro.visible = false


func _process(delta):
	_target_position =  get_global_mouse_position() #Global.nave.pos
	area_limite(self,Vector2(2000,2000))
#	print(state, " : " ,charge_timer)

	if state == States.GO_TO:
		state = _go_to_(delta)
	elif state == States.CHARGING:
		state = _charging_(delta)
	elif state == States.CRASH:
		state = _crash_(delta)
	elif state == States.GUARDING:
		state = _guarding_(delta)
	elif state == States.SPAW:
		state = _spaw_(delta)
		

func getDegress(time, maximo, duration):
	var deg = maximo*(cos(0.05*(time)*(PI/duration)))
	return deg

func _motor_animated():
	var max_position = -1.2
	$Asa_esquerda/Motor.position.y = max_position * getDegress(_time, max_position, _duration)  -4
	$Asa_direita/Motor.position.y = max_position * getDegress(_time, max_position, _duration) -4

func _asa_animated() -> void:
	asa_rotation = getDegress(_time,_maximo,_duration)
	$Asa_esquerda/lamina.rotation_degrees = asa_rotation
	$Asa_direita/lamina.rotation_degrees = asa_rotation*-1


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
#	else:
#		emit_signal("hit")



# State machine
func _on_Nave_tiro():
	if(Global.Jogo_on == true):
		$EfeitoTiro.visible = true
		var tiro1 = Laser.instance()
		var tiro2 = Laser.instance()
		tiro1.position = $cabine/Position2D.global_position
		tiro2.position = $cabine/Position2D2.global_position
		var direction1:Vector2 = _target_position - $cabine/Position2D.global_position
		var direction2:Vector2 = _target_position - $cabine/Position2D2.global_position
		tiro2.rotation_degrees = rad2deg(atan2(-direction2.x,-direction2.y))
		tiro1.rotation_degrees = rad2deg(atan2(-direction1.x,-direction1.y)) 
		tiro1.direction = direction1.normalized()
		tiro2.direction = direction2.normalized()
		get_parent().add_child(tiro1)
		get_parent().add_child(tiro2)
		guarding_mount -= 1
		

func _go_to_(delta):
	normal_animate(delta)
	#print(position.distance_to(_target_position) > min_distance_to_charge," min: ", min_distance_to_charge, " dist: ",position.distance_to(_target_position) )
	if position.distance_to(_target_position) > min_distance_to_charge:
		_move_to_target(delta,_target_position)
		$EfeitoTiro.visible = false
		charge_timer = 0
		return States.GO_TO
	return _charging_(delta)



func _charging_(delta):
	var max_charge = 0.4
	
	if charge_timer > max_charge:
		$Asa_esquerda/lamina.rotation_degrees = 30
		$Asa_direita/lamina.rotation_degrees = -30
		charge_timer = 0
		crash_direction = _target_position - $cabine.global_position
		normal_animate(delta)
		return _crash_(delta)
	
	if position.distance_to(_target_position) <= min_distance_to_charge:
		$EfeitoTiro.visible = false
		
		blink($Asa_esquerda/lamina, Color(1,1,1,2),delta)
		blink($Asa_direita/lamina, Color(1,1,1,2),delta)
		charge_timer += delta
		
		return States.CHARGING
	return _go_to_(delta)
		

func _spaw_(delta):
	normal_animate(delta)
	if position.y < 60:
		position.y += delta * speed
		return States.SPAW
	return States.GUARDING

func _crash_(delta):
	$Asa_esquerda/lamina.modulate = Color(1,1,1,2)
	$Asa_direita/lamina.modulate = Color(1,1,1,2) # 57
	charge_timer += delta
	if charge_timer > 0.2:
		charge_timer += delta
		$Asa_esquerda/lamina.rotation_degrees = -57
		$Asa_direita/lamina.rotation_degrees = 57
		$cabine/Piloto/fuego.visible = true
		position += ((charge_speed*crash_direction.normalized())*delta)*charge_timer
	return States.CRASH

func _guarding_(delta):
	normal_animate(delta)
	if guarding_mount >= 0:
		tiro_t += delta
		if tiro_t > 0.3:
			_on_Nave_tiro()
			tiro_t = 0
		elif tiro_t > 0.1:
			$EfeitoTiro.visible = false
		return States.GUARDING
	
	return _go_to_(delta)
	
func normal_animate(delta):
	$Asa_esquerda/lamina.modulate = Color(1,1,1,1)
	$Asa_direita/lamina.modulate = Color(1,1,1,1)
	_time += delta*animated_vel
	_asa_animated()
	_motor_animated()
	_smoothed_charge_direction = lerp(_smoothed_charge_direction, _target_position,0.3)
	rotate(get_angle_to(_smoothed_charge_direction))
	_smoothed_charge_direction = lerp(_smoothed_charge_direction, _target_position,0.3)
	$cabine.rotation_degrees = get_angle_to(_smoothed_charge_direction)*360
