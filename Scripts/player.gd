extends CharacterBody2D

@export var speed = 500
@export var gravity = 1000

func _physics_process(delta: float):
	velocity.y = gravity * delta
	horizontal_movement()
	move_and_slide()

func horizontal_movement():
	var horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = horizontal_input * speed
	
