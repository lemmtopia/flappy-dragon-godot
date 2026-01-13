extends Node2D

@onready var high_score_label: Label = $CanvasLayer/HighScoreLabel
@onready var gold_ui: CanvasLayer = $GoldUI
@onready var dragon: Player = $Dragon

func _ready() -> void:
	Globals.load_game()
	
	high_score_label.text = "High Score: " + str(Globals.high_score)
	gold_ui.update_gold_label()
	dragon.update_skin()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
