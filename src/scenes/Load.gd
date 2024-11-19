extends Control

var save_game := SaveGame.new()


var y = 0
var x = 0
var continua = true
# Called when the node enters the scene tree for the first time.
func _ready():
	y = 0
	x = 0
	if save_game.save_exists():
		save_game.load_savegame()
	Global.percent = get_viewport().size/Vector2(720,1334)
	#OS.alert(str(Global.percent))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (x < 0.24) and continua == true:
		$ColorRect.color = Color((y-x), y, x)
		y = x*2
		x += 0.2*delta 

	else:
		continua = false
		if x != 0:
			$ColorRect.color = Color((y-x), y, x)
			y = 2*x
			x -= 0.2*delta
	if continua == false and x <= 0:
		#OS.alert("indo para a proxima tela")
		get_tree().change_scene("res://scenes/Inicio.tscn")
