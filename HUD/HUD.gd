extends Control

class_name HUD

signal start_game

onready var score : Label = $ScoreLabel
onready var message : Label = $Message
onready var message_timer : Timer = $MessageTimer
onready var start_button : Button = $StartButton

func _ready():
	start_button.connect("pressed", self, "_on_StartButton_pressed")
	message_timer.connect("timeout", self, "_on_MessageTimer_timeout")

func _on_MessageTimer_timeout():
	message.hide()

func _on_StartButton_pressed():
	start_button.hide()
	emit_signal("start_game")
	print("emited signal")

func showMessage(text):
	message.text = text
	message.show()
	message_timer.start()

func showGameOver():
	showMessage("Game Over")
	yield(message_timer, "timeout")
	
	message.text = "Dodge The Creeps!"
	message.show()
	
	yield(get_tree().create_timer(1), "timeout")
	start_button.show()
	
func updateScore(value : int):
	score.text = str(value)
	pass

