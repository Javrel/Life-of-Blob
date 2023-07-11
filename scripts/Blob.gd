extends KinematicBody2D

var velocity: Vector2 = Vector2(0,0)
var power: int = 0
var on_ground: bool = false

const MAX_POWER: int = 1000
const GRAVITY: int = 20

onready var blobsprite = $blobsprite

var first: bool = true

func increment_power() -> void:
	if power < MAX_POWER:
		power += 20

func decrement_power() -> void:
	if abs(power) < MAX_POWER:
		power -= 20
		
func jump() -> void:
	# jump and reset power
	velocity.y = -abs(power)*2
	velocity.x = power
	
	blobsprite.animation = "jump"
	
	if abs(power) <=(MAX_POWER/2):
		$soundjumplow.play()
	else:
		$soundjumphigh.play()
		
	power = 0
	
func _physics_process(_delta):
	if first:
		blobsprite.animation = "idle"
		blobsprite.play()
		first = false
		
	if on_ground:
		if Input.is_action_pressed("ui_left"):
			if blobsprite.animation != "charge":
				blobsprite.animation = "charge"
				blobsprite.flip_h = true
			decrement_power()
		elif Input.is_action_pressed("ui_right"):
			if blobsprite.animation != "charge":
				blobsprite.animation = "charge"
				blobsprite.flip_h = false
			increment_power()
		if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
			jump()
		else:
			blobsprite.animation = "idle"
			
				
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity,Vector2(0,-1))

	

	if is_on_floor():
		if not on_ground:
		  $soundfallmed.play()	
		  on_ground = true
	else:
		on_ground = false
		velocity.y += GRAVITY
	
	if on_ground:
		velocity.x = lerp(velocity.x, 0, 0.1)	
	else:
		velocity.x = lerp(velocity.x, 0, 0.01)	
