extends Area2D

@export var speed = 400
@export var dash_speed = 1200

@export var dashColor = Color(0.954, .241, .355, 1)
@export var normColor = Color(1, 1, 1, 1)

var screen_size
var is_dashing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size
	$Dash_Timer.one_shot = true
	$Dash_Cooldown.one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.

	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		
	if Input.is_action_just_pressed("space") and (not is_dashing) and ($Dash_Cooldown.is_stopped()):
		is_dashing = true
		$Sprite2D/ColorRect.color = dashColor
		$Dash_Timer.start()
	
	if is_dashing == true:
		velocity = velocity.normalized() * dash_speed
	elif velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_dash_timer_timeout():
	is_dashing = false
	$Sprite2D/ColorRect.color = normColor
	$Dash_Cooldown.start()

func start(start_position):
	position = start_position
