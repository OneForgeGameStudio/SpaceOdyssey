extends Control

var naves = []
var newView = false # Ao entrar na cena, se move para a nave selecionada
export var padding = 0
var get_name = null

var emFoco: String = ""
var a:float = 0.0

var texture_new:Texture = preload("res://grafica/lock.png")
var shader = preload("res://new_shader.tres")

var card_out_range = false
var cards_area = 0

var index = 0

var save = SaveGame.new()

var relative_size = Vector2(1,1)
export var touch_area:Vector2 = Vector2(0.7,0.22)

func _ready():
	
	relative_size = (get_viewport().size/ Global.idealView)
	#padding = 75 * relative_size.x
	$GDNaves.rect_pivot_offset = $GDNaves.rect_size/2
	#print($GDNaves.rect_pivot_offset)
	$SeuGanho.rect_scale = relative_size
	$PowerGun.rect_scale = relative_size
	$LiveMax.rect_scale = relative_size
	$NavSkipp.rect_scale = relative_size
	$TextureRect.rect_size.x += 1
	$TextureRect2/Custo.rect_scale = relative_size
	$Buy.rect_scale = relative_size
	$Voltar.rect_scale = relative_size
	save.load_savegame()
	newView = false
	card_out_range = false
	cards_area = 0
	_loadNavs("res://grafica/Shopping/navs/") # Carrega as naves e armazena em naves
	if !naves.empty():
		_insertNavs(naves) # Insere as naves na cena
		_ordenar() # Ordena as naves
	a = 0.0
	modulate = Color(0, 0, 0)

func _process(delta):
	
	if card_out_range == true:
		if cards_area > 0:
			for nave in $GDNaves.get_children():
				nave.rect_position.x -= (500*relative_size.x)*delta
				cards_area -= (500*relative_size.x)*delta

		if cards_area < 0:
			for nave in $GDNaves.get_children():
				nave.rect_position.x += (500*relative_size.x)*delta
				cards_area += (500*relative_size.x)*delta
	
	if get_name:
		if not get_name in Global.nav_select:
			$TextureRect2/Custo.text = get_name + " R$ "+str(Global.allNavs[get_name].custo )+",00"
		elif Global.nav_select[Global.id] == get_name:
			$TextureRect2/Custo.text = "selecionada"
		else:
			$TextureRect2/Custo.text = "selecionar"

	$SeuGanho.text = "R$ " + str(Global.dinheiro) + ",00"
	if (0.9 <= a and a <= 1.0):
		modulate = Color(1, 1, 1)
		a = 2.0


	elif a < 1: 
		modulate += Color(0.1, 0.1, 0.1, 0.01)
		a += 0.1

# ------------------------------------------------------------------------- #
	$Draw.debug_navs.clear() 
# ------------------------------------------------------------------------- #
	for nave in $GDNaves.get_children():
		
		if newView == false:
			cards_area = nave.rect_position.x * $GDNaves.get_children().size()
			
			
		#teste += _calculatePosition(nave, "-", padding, "x")
		if _isCardSelected(nave):
			if nave.rect_scale.x < (1.2 * relative_size.x):
				nave.rect_scale += Vector2(0.05, 0.05)
				nave.modulate = Color(1, 1, 1)
			
			$GDNaves.move_child(nave, $GDNaves.get_child_count() - 1)
			emFoco = nave.name
			get_name = emFoco.get_slice("_", 1)
			
		else:
			nave.modulate = Color(0.588235, 0.588235, 0.588235)
			if nave.rect_scale.x >= (1 * relative_size.x):
				nave.rect_scale -= Vector2(0.05, 0.05)
# ------------------------------------------------------------------------- #
		$Draw.debug_navs.append(
					{
						"nave":nave,
						"index":nave.name
					}
				)
# ------------------------------------------------------------------------- #


	if !newView:
		if "nav_" + Global.nav_select[Global.id] != emFoco:
			for nave in $GDNaves.get_children():
				if nave.name == "nav_" + Global.nav_select[Global.id]:
					if (nave.rect_position.x < -120):
						card_out_range = true
						newView = true
				nave.rect_position.x -= 2 #45*relative_size.x
				cards_area -= 2
				
				
		else:
			newView = true
	
	if !emFoco.empty() and get_name:
		$PowerGun.text = str(Global.allNavs[get_name].poder)
		$LiveMax.text = str(Global.allNavs[get_name].vida)
		$NavSkipp.text = str(Global.allNavs[get_name].coeficiente)

func _input(event):
	
	if event is InputEventScreenDrag:

		if _card_is_out_range(event.position, cards_area):
			for nave in $GDNaves.get_children():
				nave.rect_position.x += event.relative.x
				cards_area += event.relative.x
				#print(cards_area, " Limite D: ", x_LimiteD_max)
				card_out_range = false
		else:
			
			card_out_range = true
			


func _insertNavs(navsToInsert):
	$debug.text = str(navsToInsert)
	# nav.png.import
	for i in navsToInsert: 
		var new_name = "nav_" + i.get_slice(".", 0)
		var navTextureRect = TextureRect.new()
		var pathNav = "res://grafica/Shopping/navs/" + (i.get_slice(".", 0)+"."+i.get_slice(".", 1))
		#print(pathNav)
		var navTexture: Texture = load(pathNav)
		navTextureRect.name = new_name
		navTextureRect.expand = false
		navTextureRect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		navTextureRect.texture = navTexture
		navTextureRect.rect_scale = relative_size
		navTextureRect.rect_pivot_offset.x = navTextureRect.texture.get_size().x/2 
		navTextureRect.rect_pivot_offset.y = navTextureRect.texture.get_size().y/2 
		navTextureRect.margin_bottom = 191
		navTextureRect.margin_left = -156
		navTextureRect.margin_right = 156
		navTextureRect.margin_top = -191
		navTextureRect.anchor_bottom = 0.5
		navTextureRect.anchor_left = 0.5
		navTextureRect.anchor_right = 0.5
		navTextureRect.anchor_top = 0.5
		navTextureRect.rect_position.x +=  (200*relative_size.x)*index
#		print("anchor_bottom: ", navTextureRect.anchor_bottom, " anchor_left: ", navTextureRect.anchor_left, " anchor_top: ", navTextureRect.anchor_top, " anchor_right: ", navTextureRect.anchor_right, " offset: ", navTextureRect.rect_pivot_offset)

		if not i.get_slice(".", 0) in Global.nav_select:
			navTextureRect.material = ShaderMaterial.new()
			navTextureRect.material.shader = shader
			navTextureRect.material.set_shader_param("locked_icon",texture_new)
		index +=1
# --------------------------------------------------------------- #
#		$Draw.debug_navs.append(
#			{
#				"nave":navTextureRect,
#				"index":index
#			}
#		)
# --------------------------------------------------------------- #
		$GDNaves.add_child(navTextureRect)

func _loadNavs(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if !dir.current_is_dir():
				var name = String(fileName)
				if name.find("import") != -1 and name != ".DS_Store":
					naves.append(name)
			fileName = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func _isCardSelected(card):
	var corection = (200-(relative_size.x*200))
	var xLimitMin = _calculatePosition(card, "-", padding, "x") + card.rect_position.x + corection
	var xLimitMax =  _calculatePosition(card, "+", padding, "x") + card.rect_position.x  + corection
	#if card.name == "nav_Spectra":
		#print("Limit ",Vector2(xLimitMin,xLimitMax)," ", card.name," --> ", Vector2((get_viewport().size.x*0.45),(get_viewport().size.x*0.55))," is select: ", xLimitMin <= (get_viewport().size.x*0.45) and xLimitMax >= (get_viewport().size.x*0.55))
		#print("Limit ",corection)
	$Draw.in_half.altura = Vector2(0,get_viewport().size.y)
	$Draw.in_half.base = Vector2((get_viewport().size.x*0.45),(get_viewport().size.x*0.55))
	return xLimitMin <= (get_viewport().size.x*0.45) and xLimitMax >= (get_viewport().size.x*0.55)

func _calculatePosition(obj, opera, k, axis):
	
	var diferencaPs = 0
	if axis == "x":
		if opera == "-":
			diferencaPs = obj.rect_position.x - (obj.texture.get_size().x  / 2)*obj.rect_scale.x + k
		elif opera == "+":
			diferencaPs = obj.rect_position.x + (obj.texture.get_size().x  / 2)*obj.rect_scale.x - k
	else: 
		if opera == "-":
			diferencaPs = obj.rect_position.y - (obj.texture.get_size().y  / 2)*obj.rect_scale.y 
		elif opera == "+":
			diferencaPs = obj.rect_position.y + (obj.texture.get_size().y / 2)*obj.rect_scale.y
	
	return diferencaPs

func _on_Buy_pressed():
	# Verifique se a nave não está na lista Global.nav_select
	if not get_name in Global.nav_select:
		# Adicione o nome da nave selecionada à lista Global.nav_select 
		if Global.dinheiro >= Global.allNavs[get_name].custo:
			Global.dinheiro -= Global.allNavs[get_name].custo
			$GDNaves.get_children()[$GDNaves.get_child_count()-1].material = null
			Global.nav_select.append(get_name)
			
	else:
		#print("Esta nave já foi comprada.")
		pass

	for i in range(len(Global.nav_select)) :
		if get_name == Global.nav_select[i]:
			Global.id = i
			save.write_savegame()


func _ordenar(): 
	var ordem = $GDNaves.get_child_count()
	for nave in $GDNaves.get_children():
		$GDNaves.move_child(nave, ordem)
		ordem -= 1

func _on_Voltar_pressed():
	get_tree().change_scene("./scenes/Inicio.tscn")


func _card_is_out_range(event, cards_area):
	var y_Limite_menor = $GDNaves.rect_size.y * touch_area.x 
	var y_Limite_maior = $GDNaves.rect_size.y * touch_area.y 
	$Draw.touch_zone.altura = Vector2(y_Limite_menor,y_Limite_maior)
	$Draw.touch_zone.base = Vector2(0,$GDNaves.rect_size.x)
	var x_LimiteD_max = 20 + ($GDNaves.get_children().size() *  (550*relative_size.x)) 
	var x_LimiteE_max = 20 - ($GDNaves.get_children().size() *  (220*relative_size.x)) 

	if y_Limite_maior < event.y and event.y < y_Limite_menor and cards_area <  x_LimiteD_max and cards_area >  x_LimiteE_max:
		return true
	else:
		return false





















