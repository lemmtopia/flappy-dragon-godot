extends Node2D

@onready var icon: Sprite2D = $Icon
@onready var button: Button = $Button
@onready var gold_label: Label = $GoldLabel

@export var skin_index : int = 0

func _ready() -> void:
	icon.texture = load(Globals.skin_array[skin_index].path)
	gold_label.text = str(Globals.skin_array[skin_index].price)
	
	if Globals.skin_array[skin_index].enabled == true:
		change_button_to_equip()

func try_buy_item():
	if Globals.gold < Globals.skin_array[skin_index].price:
		return
	
	Globals.gold -= Globals.skin_array[skin_index].price
	Globals.skin_array[skin_index].enabled = true
	
	change_button_to_equip()
	Globals.save_game()

func change_button_to_equip():
	button.text = "Equip"

func _on_button_pressed() -> void:
	if Globals.skin_array[skin_index].enabled == true:
		Globals.skin_index = skin_index
		Globals.save_game()
	else:
		try_buy_item()

func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
