extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var flap_strength : float = 150
@export var gravity : float = 500

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if Input.is_action_just_pressed("flap"):
		velocity.y = -flap_strength
	
	if velocity.y < 0:
		sprite_2d.frame = 1
	else:
		sprite_2d.frame = 0
	
	velocity.y = clamp(velocity.y, -flap_strength, flap_strength)
	move_and_slide()
