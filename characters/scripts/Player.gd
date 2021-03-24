extends Area2D

class_name Player


onready var collider : CollisionShape2D = $Collider


export var speed : int = 400
var velocity : Vector2 = Vector2()
var screen_size : Vector2 = Vector2()


signal moving(dir)
signal hit
signal died


func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):	
	velocity = _getVelocity()
	
	_moveAnimation(velocity)
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	

func _getVelocity() -> Vector2:
	var dir : Vector2
	var velocity : Vector2
	
	dir.x = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	dir.y = -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))

	if(dir.length() > 0):
		velocity = dir.normalized() * speed
	return velocity
	

func _moveAnimation(dir : Vector2):
	emit_signal("moving", dir)
	

func start(pos : Vector2):
	position = pos
	show()
	collider.disabled = false


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	collider.set_deferred("disabled", true)
