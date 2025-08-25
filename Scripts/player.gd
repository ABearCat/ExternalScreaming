extends CharacterBody2D

@export var speed = 500
@export var gravity = 1000
@export var jump_height = -500
var gravity_toggle = true
var is_climbing = true
var can_attack = true
var wait_time = 0.1

func _physics_process(delta: float):
	velocity.y += gravity * delta
	horizontal_movement()
	move_and_slide()
	
	player_animations()
	
func _input(event: InputEvent):
	#BLAST EM
	if event.is_action_pressed("shoot"):
		#use a timer for attack cooldown
		if can_attack == true:
			can_attack = false
			#I think this is a 0.1 second CD on attacking?
			get_tree().create_timer(wait_time).timeout.connect(func(): can_attack = true)
			#Fire Bullet, Gonna worry about this later after I actually get enemies and whatnot working
	
	#GO UP
	if event.is_action("jump") and is_on_floor():
		velocity.y = jump_height
		
	if is_climbing == true:
		if Input.is_action_just_pressed("move_up"):
			gravity = 0
			velocity.y = -500
		if Input.is_action_just_pressed("move_down"):
			gravity = 0
			velocity.y = 500
			
		
			
	else:
		gravity = 1000
		is_climbing = false

func horizontal_movement():
	var horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = horizontal_input * speed
	
func player_animations():
	if Input.is_action_pressed("move_left") || Input.is_action_just_released("move_left"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("Move")
	if Input.is_action_pressed("move_right") || Input.is_action_just_released("move_right"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Move")
