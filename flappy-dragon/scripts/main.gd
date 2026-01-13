extends Node2D

signal gold_changed
signal hit

@onready var parallax_background: ParallaxBackground = $ParallaxBackground
@onready var building_timer: Timer = $BuildingTimer
@onready var coin_timer: Timer = $CoinTimer
@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var gold_ui: CanvasLayer = $GoldUI

@export var building_scene : PackedScene
@export var coin_scene : PackedScene
@export var game_over_scene : PackedScene
@export var scroll_speed : float = 60

var score : int = 0

func _ready() -> void:
	building_timer.start()
	coin_timer.start()

func _process(delta: float) -> void:
	parallax_background.scroll_offset.x -= scroll_speed * delta

func _on_dragon_hit() -> void:
	var game_over = game_over_scene.instantiate()
	game_over.connect("restart_game", _on_game_over_restart_game)
	game_over.connect("quit", _on_game_over_quit)
	add_child(game_over)
	
	if score > Globals.high_score:
		Globals.high_score = score
	
	hit.emit()
	
	building_timer.stop()
	coin_timer.stop()
	scroll_speed = 0

func _on_game_over_restart_game() -> void:
	get_tree().reload_current_scene()

func _on_building_timer_timeout() -> void:
	var building = building_scene.instantiate()
	var is_top_building : bool = [false, false, false, true, true].pick_random()
	
	var y_position = randf_range(126, 98)
	
	if is_top_building:
		building.scale.y = -1
		y_position = randf_range(28, 62)
	
	building.position = Vector2(300, y_position)
	building.connect("add_score", _on_building_add_score)
	add_child(building)

func _on_building_add_score():
	score += 1
	score_label.text = str(score)

func _on_game_over_quit():
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")

func _on_coin_timer_timeout() -> void:
	var coin : Area2D = coin_scene.instantiate()
	var y_position = randf_range(90, 120)
	coin.position =  Vector2(300, y_position)
	coin.connect("add_gold", _on_coin_add_gold)
	add_child(coin)

func _on_coin_add_gold():
	Globals.gold += 1
	gold_changed.emit()
