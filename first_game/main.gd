extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Hud/StopButton.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dashcooldown = "%.2f" % $Player/Dash_Cooldown.time_left
	var dashtimer = "%.2f" % $Player/Dash_Timer.time_left
	print(dashcooldown)
	print(dashtimer)
	$Hud.update_dash_cooldown(dashcooldown)
	$Hud.update_dash_timer(dashtimer)
	
	if Input.is_action_pressed("stop_game"):
		stop_game()

func new_game():
	$Player.show()
	$Player.start($StartPosition.position)
	$Player.update_game_on(true)
	$Player.speed = 400

func stop_game():
	$Player.update_game_on(false)
	$Player/Dash_Cooldown.stop()
	$Player/Dash_Timer.stop()
	$Player.speed = 0
	$Hud/StopButton.hide()
	$Hud/StartButton.show()

