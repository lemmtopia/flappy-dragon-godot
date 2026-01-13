extends Node2D

signal start_game

@onready var parallax_background: ParallaxBackground = $ParallaxBackground
@onready var restart_timer: Timer = $RestartTimer
@onready var building_timer: Timer = $BuildingTimer
@onready var score_label: Label = $CanvasLayer/ScoreLabel

@export var building_scene : PackedScene
@export var scroll_speed : float = 60

var score : int = 0

func _ready() -> void:
	start_game.emit()

func _process(delta: float) -> void:
	parallax_background.scroll_offset.x -= scroll_speed * delta

func _on_dragon_hit() -> void:
	restart_timer.start()
	building_timer.stop()
	scroll_speed = 0

func _on_restart_timer_timeout() -> void:
	get_tree().reload_current_scene()

func _on_start_game() -> void:
	building_timer.start()

func _on_building_timer_timeout() -> void:
	var building = building_scene.instantiate()
	var is_top_building : bool = [false, true].pick_random()
	
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
