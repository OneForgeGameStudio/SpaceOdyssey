extends Control


var rapido = 0.5
var devagar = 0.1
var normal = 0.25
var rng = RandomNumberGenerator.new()
var relative_size = Vector2(1,1)
export var padding: float = 100
export var origem: float = 0.4

func _ready():
	relative_size = (get_viewport().size/ Global.idealView)
	#print(relative_size)
	#print(get_viewport().size, "\n", Global.percent)
	$back_1/ParallaxBackground.scale = relative_size
	
#	$Container/Button.rect_scale = relative_size
#	$Container/Shop.rect_scale = relative_size
#	$Container/Fases.rect_scale = relative_size
	
	# Start Button
	$Container/Button.rect_pivot_offset = $Container/Button.rect_size/2
	$Container/Button.margin_top = (get_viewport().size.y*origem) - ($Container/Button.rect_size.y/2) + (padding*2) * relative_size.y
	$Container/Button.margin_bottom = 0
	$Container/Button.margin_right = 0
	$Container/Button.margin_left = (get_viewport().size.x/2) - ($Container/Button.rect_size.x/2)


	# Shop Button
	$Container/Shop.rect_pivot_offset = $Container/Shop.rect_size/2 
	$Container/Shop.margin_top = (get_viewport().size.y*origem) - ($Container/Shop.rect_size.y/2)  + (padding*3) * relative_size.y
	$Container/Shop.margin_bottom = 0
	$Container/Shop.margin_right = 0
	$Container/Shop.margin_left = (get_viewport().size.x/2) - ($Container/Shop.rect_size.x/2)

	# Fases Button
	$Container/Fases.rect_pivot_offset = $Container/Fases.rect_size/2
	$Container/Fases.margin_top = (get_viewport().size.y*origem) - ($Container/Fases.rect_size.y/2) + (padding*1) * relative_size.y
	$Container/Fases.margin_bottom = 0
	$Container/Fases.margin_right = 0
	$Container/Fases.margin_left = (get_viewport().size.x/2) - ($Container/Fases.rect_size.x/2)
	
#	$Button.rect_position.y *= relative_size.y
#	$Shop.rect_position.y *= relative_size.y
#	$Fases.rect_position.y *= relative_size.y
	rect_size.x = get_viewport().size.x #* Global.percent.x
	rect_size.y = get_viewport().size.y #* Global.percent.y
	#OS.alert("Chegou")
	#$back_3.rect_position = Vector2((get_viewport().size.x/2),(get_viewport().size.y/2))
	#$back_2.rect_position = Vector2((get_viewport().size.x/2),(get_viewport().size.y/2))
	#$back_1.rect_position = Vector2((get_viewport().size.x/2),(get_viewport().size.y/2))
#	$back_1/ParallaxBackground/primeiro/Sprite.scale = get_viewport().size
#	$back_1/ParallaxBackground/quarto/Sprite.scale = get_viewport().size
#	$back_1/ParallaxBackground/segundo/Sprite.scale = get_viewport().size

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")

func _process(delta):
	$back_1/ParallaxBackground/primeiro.motion_offset.y += (150*delta)*0.1
	$back_1/ParallaxBackground/quarto.motion_offset.y += (150*delta)*0.4
	$back_1/ParallaxBackground/segundo.motion_offset.y += (150*delta)*2

func _on_Fases_pressed():
	rng.randomize()
	var rand = rng.randf_range(0.0, 1.0)
	var rand2 = rng.randf_range(0.0, 1.0)
	var rand3 = rng.randf_range(0.0, 1.0)

	
	$Container/Fases.modulate = Color(rand,rand2, rand3)


func _on_Shop_pressed():
	get_tree().change_scene("res://scenes/Shoping.tscn") 
	
