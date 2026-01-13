extends Node

var high_score : int = 0
var gold : int = 0

var skin_array : Array[Dictionary] = [
	{
		path = "res://assets/dragon_green.png",
		price = 0,
		enabled = true
	},
	{
		path = "res://assets/dragon_red.png",
		price = 5,
		enabled = false
	},
	{
		path = "res://assets/dragon_yellow.png",
		price = 15,
		enabled = false
	}
]

var skin_index : int = 0
