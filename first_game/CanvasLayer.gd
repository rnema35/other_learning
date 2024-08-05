extends CanvasLayer

signal start_game
signal stop_game

func update_dash_cooldown(time):
	$Cooldown/DashCooldown.text = str(time)

func update_dash_timer(time):
	$Dash/DashTimer.text = str(time)

func _on_start_button_pressed():
	#$StartButton.hide()
	#$StopButton.show()
	emit_signal("start_game")


func _on_stop_button_pressed():
	#$StartButton.show()
	#$StopButton.hide()
	emit_signal("stop_game")
