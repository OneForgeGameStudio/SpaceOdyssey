extends Node

var dinheiro = 100
var pontos = 0
var Jogo_on = true
var nave = {
	"pos":Vector2(0,0),
	"coeficiente": 1.20
		}

var nav_select = ["Normal"]
var scaleMeteoro
var velMeteoro
var vel = 3
var go = false
var shake = false
var id = 0
var delta = 0.01

var safeArea = {
	"min":0.3,
	"max":0.7
}

var idealView = Vector2(720,1334)
var percent = Vector2(1,1)

var allNavs = {
#	"hack":OS.alert("Hack","bitch!"),
	"Normal":{
		"custo":0,
		"coeficiente": 2.20,
		"poder":9,
		"vida":1,
		"color_machine":0
	},
	"Obsidian":{
		"custo":140,
		"coeficiente": 5.80,
		"poder":9,
		"vida":1,
		"color_machine": 0.11
	},
	"Placeholder":{
		"custo":200,
		"coeficiente": 6.20,
		"poder":90,
		"vida":10,
		"color_machine":0.8
	},
	"Spectra":{
		"custo":85,
		"coeficiente": 3.20,
		"poder":11,
		"vida":1,
		"color_machine": -0.28
	},
	"Teste":{
		"custo":185,
		"coeficiente": 1.20,
		"poder":9,
		"vida":1,
		"color_machine": -0.38
	}
}




