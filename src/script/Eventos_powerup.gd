extends Node2D


export var powerups_event: Array = []
const weigth_img = 46

# Inicialização
# Função para chamada de cards
# Gerenciamento da aparição de cards
var x_viewport = 0
#var y_viewport = ((get_viewport().size.y/100)*20) * Global.percent.y
#var choiced_index = 0


func _ready():
	x_viewport = ((get_viewport().size.x/2) - (weigth_img/2) + 12) * Global.percent.x
	choice_power(2)

func choice_power(n_options=2):
	
	if n_options > 3 or n_options <= 0 or n_options > powerups_event.size():
		print("Erro")
		return 
	
	var index:int = 1
	
	if n_options == 2:
		var margin = weigth_img*0.3
		for i in powerups_event:
			if index > 2:
				break
			var powerup = i.instance()
			if index == 1:
				powerup.position.x = x_viewport*0.79 + margin
			else:
				powerup.position.x = x_viewport*0.79 + weigth_img * 3 + margin*2 
			powerup.position.y = 0
			print("Power: ",powerup.position.x, " name: ", powerup.name)
			self.add_child(powerup)
			index += 1

	if n_options == 3:
		var percent_controle = 0.71
		var margin = weigth_img*0.2
		for i in powerups_event:
			var powerup = i.instance()
			if index == 1:
				powerup.position.x = x_viewport*percent_controle + margin
			elif index == 2:
				powerup.position.x = x_viewport*percent_controle + weigth_img * 2 + margin*2 
			else:
				powerup.position.x = x_viewport*percent_controle + weigth_img * 4 + margin*3
			powerup.position.y = 0
			print("Power: ",powerup.position.x, " name: ", powerup.name)
			self.add_child(powerup)
			index += 1


func deferred_powers(power_choice):
	for i in self.get_children():
		if i.status_change == power_choice:
			i.choiced()
