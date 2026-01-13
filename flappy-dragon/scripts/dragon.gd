extends CharacterBody2D
class_name Player

signal hit

@onready var sprite: Sprite2D = $Sprite
@onready var shape: CollisionShape2D = $Shape

@export var flap_strength : float = 150
@export var gravity : float = 500

var is_start_game : bool = true
var can_control : bool = true
var is_dead : bool = false

func _physics_process(delta: float) -> void:
	if is_start_game:
		velocity.y += gravity * delta
		if Input.is_action_just_pressed("flap") and can_control:
			velocity.y = -flap_strength
		
		if velocity.y < 0:
			sprite.frame = 1
		else:
			sprite.frame = 0
		
		if position.y < -16 or position.y > 160 + 16:
			die()
		
		
		velocity.y = clamp(velocity.y, -flap_strength, flap_strength)
		move_and_slide()

func die():
	if is_dead:
		return
		
	is_dead = true
	
	can_control = false
	shape.disabled = true
	
	hit.emit()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("obstacles"):
		call_deferred("die")
