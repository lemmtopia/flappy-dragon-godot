extends Area2D

signal add_gold

@export var speed : float = 200

func _ready() -> void:
	get_parent().connect("hit", _on_main_hit)

func _process(delta: float) -> void:
	position.x -= speed * delta
	if position.x < -48:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		add_gold.emit()
		queue_free()

func _on_main_hit():
	speed = 0
