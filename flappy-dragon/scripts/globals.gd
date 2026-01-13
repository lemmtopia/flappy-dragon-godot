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

func save_game():
	var save_dict : Dictionary = {
		"high_score" = high_score,
		"gold" = gold,
		"skin_array" = [
			skin_array[0].enabled,
			skin_array[1].enabled,
			skin_array[2].enabled
		],
		"skin_index" = skin_index
	}
	
	var file = FileAccess.open("user://save.sav", FileAccess.WRITE)
	var json_string = JSON.stringify(save_dict)
	
	file.store_string(json_string)

func load_game():
	if not FileAccess.file_exists("user://save.sav"):
		save_game()
		return
	
	var file = FileAccess.open("user://save.sav", FileAccess.READ)
	var json_string = file.get_as_text()
	
	var save_dict = JSON.parse_string(json_string)
	
	high_score = save_dict.high_score
	gold = save_dict.gold
	
	for i in range(0, 3):
		skin_array[i].enabled = save_dict.skin_array[i]
	
	skin_index = save_dict.skin_index
