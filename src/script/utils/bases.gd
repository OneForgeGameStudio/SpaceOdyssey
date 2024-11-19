extends Node2D
class_name Bases

var is_shaking = true
var shake_duration = 1.3  # Duração da vibração em segundos
var shake_amplitude = 5.0  # Amplitude da vibração (o quanto a tela vai tremer)

func start_shake():
	if is_shaking:
		var random_offset = Vector2(rand_range(-shake_amplitude+self.position.x, shake_amplitude+self.position.x), rand_range(-shake_amplitude+self.position.y, shake_amplitude+self.position.y))
		self.position = random_offset



var i = 0
var blink_timer:float = 0
var blink:bool = false



func blink(object, color: Color, delta):
	if blink == true:
		blink_timer += delta
		if blink_timer >= 0.15:
			object.modulate = color
			blink_timer = 0
		else :
			object.modulate = Color(1,1,1,1)
		
		
	else:
		object.modulate = Color(1,1,1,1)

#var deg = maximo*(cos(0.05*(blink_timer)*(PI/duration)))
