extends KinematicBody2D

var velocity = Vector2(0,0)
var power = 0
var max_power = 200

const SPEED = 180

func increment_power():
	if power < max_power:
		power += 1
		
func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		increment_power()
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		increment_power()
	if Input.is_action_just_released("ui_right"):
		# jump and reset power
		power = 0
	if Input.is_action_just_released("ui_left"):
		# jump and reset power
		power = 0
			
	velocity.y = velocity.y + 30
	
	move_and_slide(velocity)
	
	print(power)
	velocity.x = lerp(velocity.x, 0, 0.1)	
