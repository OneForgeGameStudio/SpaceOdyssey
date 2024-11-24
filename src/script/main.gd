extends Control


#var nav_posicoes = []

var timePowerEvents = {
	"impulso":6.0,
	"bullet":12.0
}

var eventos = [
	[
		preload("res://DEV_TESTE/Eventos/A.gd"),
		preload("res://DEV_TESTE/Eventos/B.gd"),
		preload("res://DEV_TESTE/Eventos/C.gd"), # Eventos normais
		preload("res://DEV_TESTE/Eventos/D.gd")
	],
	[
		preload("res://DEV_TESTE/Eventos/onda_inimigos/easy_wave.gd"), # Eventos troca de layout
#		preload("res://DEV_TESTE/Eventos/onda_inimigos/B.gd"),
#		preload("res://DEV_TESTE/Eventos/onda_inimigos/C.gd")
	],
	[
		preload("res://DEV_TESTE/Eventos/bosses/A.gd"), # Eventos boss
		preload("res://DEV_TESTE/Eventos/bosses/B.gd"),
		preload("res://DEV_TESTE/Eventos/C.gd")
	]
]


var timer = 0

var a = 0
var kmPercorrido = 0
var btn = false

# warning-ignore:unused_signal
signal coin_anime
# warning-ignore:unused_signal
signal Nave_powerup


var _coinx = 0


var event_index = 0
var event_type = 0

var bg_eventos = [
	preload("res://prefebs/objetos_bg/satelite_obitando.tscn")
]
var save_game := SaveGame.new()


func _ready():
#	$debug.create_line(Vector2(get_viewport().size.x/2,0), Vector2(get_viewport().size.x/2,get_viewport().size.y), Color(0,1,0), 4)
#	$debug.create_line(Vector2(get_viewport().size.x*Global.safeArea["max"],0), Vector2(get_viewport().size.x*Global.safeArea["max"],get_viewport().size.y), Color(0,0.3,0.7), 2)
#	$debug.create_line(Vector2(get_viewport().size.x*Global.safeArea["min"],0), Vector2(get_viewport().size.x*Global.safeArea["min"],get_viewport().size.y), Color(0,0.3,0.7), 2)
	save_game.load_savegame()
	var start = eventos[0][3].new()
	event_config(start)
	add_child(start)
	$HUD/naveSafeArea.visible = false
	$AudioMain.volume_db = -60
	
	$HUD/naveSafeArea.modulate.a = 0
	print(Global.allNavs[Global.nav_select[Global.id]]["equilibrio"])
	$HUD/naveSafeArea.rect_scale.x = Global.allNavs[Global.nav_select[Global.id]]["equilibrio"]
	
	Global.Jogo_on = true
	ui_configuration()
	$Nave.start_spanw_animated(Vector2((get_viewport().size.x)/2,(get_viewport().size.x/100)*120))

func _process(delta):
	
	if $Nave.start == false and $HUD/naveSafeArea.modulate.a != 1:
		$HUD/naveSafeArea.visible = true
		$HUD/naveSafeArea.modulate.a += 0.1
	
	if $Eventos_iniciais.get_children().size() > 0:
		$debug.text = str($Eventos_iniciais.get_children()[0].name)
	if(Global.Jogo_on == true):
		if ($Nave.position.x > get_viewport().size.x or $Nave.position.x < 0 ):
			Global.Jogo_on = false
		Global.delta = delta
		if $AudioMain.volume_db <= -20:
			$AudioMain.volume_db +=2
		a += delta
		Global.nave.pos = $Nave.position
		Global.nave.coeficiente = $Nave.coeficiente
		$HUD/km.text = str(Global.nave.coeficiente)+" K/s"
		kmPercorrido += 1100
		if (a >=2):
			a = 0
			timer += 1
			
		$HUD/Tempo.text = str(int(timer))+" Day"

	else:
		if $AudioMain.volume_db != -80:
			$AudioMain.volume_db -= 2
		
		if $HUD/Tempo.rect_position.y < (get_viewport().size.y/2)-60:
			$HUD/Tempo.rect_position.y += 5*(1+delta)
		if $Nave.frame >= $Nave.anima_fim:
			$Nave.visible = false
			$HUD/Reiniciar.visible = true
			$HUD/VoltarMenu.visible = true
			$HUD/score.visible = true
			$HUD/score.text = str(kmPercorrido) + " Km"

func _on_Reiniciar_pressed():
	Global.Jogo_on = true
	save_game.write_savegame()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Main.tscn")

func ui_configuration():
	#$HUD.rect_size = get_viewport().size
	$HUD/VoltarMenu.position.x = ((get_viewport().size.x/2) * Global.percent.x - ($HUD/VoltarMenu.normal.get_width()/2)) -70
	$HUD/Reiniciar.position.x = ((get_viewport().size.x/2) * Global.percent.x - ($HUD/VoltarMenu.normal.get_width()/2)) -70
	$HUD/VoltarMenu.position.y = ((get_viewport().size.y/100)*20) * Global.percent.y
	$HUD/Reiniciar.position.y = ((get_viewport().size.y/100)*80) * Global.percent.y
	$HUD/score.visible = false
	$Nave.visible = true
	$HUD/Reiniciar.visible = false
	$HUD/VoltarMenu.visible = false
	


func event_config(obj):
	obj.connect("finsh", self, "_finish")
	obj.grupo = $Eventos_iniciais
	

var type_event = 0 # Só a 3 tipos de eventos [ Normais, Inimigos, Bosses ] 
var count_event = 0

func _finish():
	if type_event == 1:
		$Eventos_powerup.choice_power(2)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	event_index = rng.randi_range(0, eventos[type_event].size()-1)
	var start = eventos[type_event][event_index].new()
	event_config(start)
	add_child(start)
	if count_event > 3 and type_event != 1:
		type_event = 1
		count_event = 0
	else:
		count_event += 1


func _on_VoltarMenu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Inicio.tscn") 


func _on_Control_coin_anime():
	_coinx += 1
	$HUD/Coins_tex.text = str(_coinx)
	save_game.write_savegame()
	


func _on_Control_Nave_powerup(event):
	$Nave.status = event
	$Eventos_powerup.deferred_powers(event)
	$TimerPowerControl.wait_time = timePowerEvents[event]
	$TimerPowerControl.start()
	print("cacete: ", timePowerEvents[event])
	

func _on_HUD_gui_input(event):
	$Nave.set_target(event)



func _on_TimerPowerControl_timeout():
	$Nave.status = ""
	$TimerPowerControl.stop()



