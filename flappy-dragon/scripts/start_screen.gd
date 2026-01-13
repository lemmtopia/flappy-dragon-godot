extends Node2D

@onready var high_score_label: Label = $CanvasLayer/HighScoreLabel

func _ready() -> void:
	high_score_label.text = "HI: " + str(Globals.high_score)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")



func _on_quit_button_pressed() -> void:
	get_tree().quit()
