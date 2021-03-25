extends AnimatedSprite



func _ready():
# warning-ignore:return_value_discarded
	get_parent().connect("moving", self, "_start_player_animation")
	
func _start_player_animation(dir : Vector2):
	if(dir.length() > 0):
		if(abs(dir.x) > abs(dir.y)):
			horizontalAnimation(dir)
		elif(abs(dir.y) > abs(dir.x)):
			verticalAnimation(dir)
	else:
		stop()
		flip_v = false
		frame = 0

func horizontalAnimation(dir : Vector2):
	animation = "horizontal"
	flip_v = false
	
	if(dir.x < 0):
		flip_h = true
	elif(dir.x > 0):
		flip_h = false
		
	play()
	
func verticalAnimation(dir : Vector2):
	animation = "vertical"
	
	if(dir.y < 0):
		flip_v = false
	elif(dir.y > 0):
		flip_v = true
	
	play()
