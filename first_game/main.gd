extends Node

var game_on = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$PLayer2.hide()
	$Hud/StopButton.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dashcooldown = "%.2f" % $PLayer2/Dash_Cooldown.time_left
	var dashtimer = "%.2f" % $PLayer2/Dash_Timer.time_left
	$Hud.update_dash_cooldown(dashcooldown)
	$Hud.update_dash_timer(dashtimer)
	
	if Input.is_action_just_pressed("space") and not game_on:
		new_game()
	
	if Input.is_action_just_pressed("stop_game") and game_on:
		stop_game()
	

func new_game():
	game_on = true
	
	$PLayer2.show()
	$PLayer2.start($StartPosition.position)
	$PLayer2.update_game_on(game_on)
	$PLayer2.speed=400
	$PLayer2.dash_speed=1000
	
	$Hud/StartButton.hide()
	$Hud/StopButton.show()

func stop_game():
	game_on = false
	
	$PLayer2.update_game_on(game_on)
	$PLayer2/Dash_Cooldown.stop()
	$PLayer2/Dash_Timer.stop()
	$PLayer2.speed = 0
	$PLayer2.dash_speed = 0
	
	$Hud/StopButton.hide()
	$Hud/StartButton.show()

