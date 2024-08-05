extends CharacterBody2D

@export var speed = 400
@export var dash_speed = 1200

@export var dashColor = Color(0.954, .241, .355, 1)
@export var normColor = Color(1, 1, 1, 1)

var screen_size
var is_dashing = false
var game_on = false

func _ready():
	screen_size = get_viewport_rect().size
	$Dash_Timer.one_shot = true
	$Dash_Cooldown.one_shot = true

func get_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_action_just_pressed("space") and (not is_dashing) and ($Dash_Cooldown.is_stopped()):
		is_dashing = true
		$CollisionShape2D/ColorRect.color = dashColor
		$CollisionShape2D.disabled = true
		$Dash_Timer.start()
		
	
	if is_dashing:
		velocity = input_dir * dash_speed
	else: 
		velocity = input_dir * speed

func _physics_process(delta):
	if game_on:
		get_input()
		move_and_collide(velocity * delta)

func _on_dash_timer_timeout():
	is_dashing = false
	$CollisionShape2D/ColorRect.color = normColor
	$CollisionShape2D.disabled = false
	$Dash_Cooldown.start()

func update_game_on(game_on_bool):
	game_on = game_on_bool

func start(start_position):
	position = start_position
