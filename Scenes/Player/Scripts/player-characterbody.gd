extends CharacterBody2D

var speed : float = 100
@export var gravity : float = 980.0
@export var jump_force : float = -400
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var effect_player: AnimationPlayer = $EffectPlayer


var is_charging_jump : bool = false 
var charge_time : float = 0.0
var max_charge_time : float = 0.5
var crouch_time := 0.12


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	
	# Physics 
	# build the jump
	# set the crouch
	# increase the charge time until max time reached
	if is_charging_jump:
		charge_time += delta
		charge_time = min(charge_time, max_charge_time)
		# after a brief crouch, show charge_up while holding
		if charge_time >= crouch_time and effect_player.current_animation != "charge_up":
			effect_player.play("charge_up")
		
		
	# Store Direction
	var direction : Vector2 = Vector2.ZERO 
	

	# Read Input
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if direction != Vector2.ZERO:
		animation_player.play("walk")
		if direction.x <0:
			sprite_2d.flip_h = true
		else:
			sprite_2d.flip_h = false
	elif !is_charging_jump:
		animation_player.play("idle")
	
	
	
	velocity.x = direction.normalized().x * speed
	move_and_slide()


	
func _unhandled_input(event: InputEvent) -> void:
	# input
# If the jump is pressed
# check to see when jump is released
	
	if event.is_action_pressed("jump") and is_on_floor():
		# start charging jump
		is_charging_jump = true
		charge_time = 0.0
		animation_player.play("crouch")
	
		
		
	if event.is_action_released("jump") and is_charging_jump:
		# release jump
		var charge_ratio = charge_time / max_charge_time
		charge_ratio = 0.5 if charge_ratio < 0.5 else charge_ratio
		velocity.y = jump_force * charge_ratio
		is_charging_jump = false
		effect_player.stop()
		animation_player.play("jump")
		
		
		
func die () -> void:
	await SceneTransition.fade_to_black()
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
