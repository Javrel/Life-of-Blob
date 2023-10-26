extends CharacterBody2D

var power: int = 0
var on_ground: bool = false

var controllable = true

var is_dead = false

const MAX_POWER: float = 1000
const GRAVITY: int = 20

@onready var blobsprite = $blobsprite

var first: bool = true

func increment_power() -> void:
	power = min(power+20,MAX_POWER)

func decrement_power() -> void:
	power = max(power-20, -MAX_POWER)
		
func jump() -> void:
	# jump and reset power
	velocity.y = -abs(power)*2
	velocity.x = power

	blobsprite.animation = "jump"
	blobsprite.play()
	
	if abs(power) <=(MAX_POWER/2):
		$soundjumplow.play()
	else:
		$soundjumphigh.play()
		
	power = 0

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	# $blobsprite.play("dead")
	$Timer.start()
	
func do_power(flip: bool):
	if flip:
		decrement_power()
		blobsprite.flip_h = flip
	else:
		increment_power()
		blobsprite.flip_h = flip
	
	if abs(power) < MAX_POWER:
		if blobsprite.animation != "charge_one":							
			blobsprite.play("charge_one")
	else:
		if blobsprite.animation != "charge_two":
			blobsprite.play("charge_two")
			
	print(blobsprite.animation)
	
	
	
	
func _physics_process(_delta):
	if first:
		blobsprite.animation = "idle"
		blobsprite.play()
		first = false
	if is_dead == false:
		if controllable:	
			if on_ground:
				if Input.is_action_pressed("ui_left"):
					do_power(true)
				elif Input.is_action_pressed("ui_right"):
					do_power(false)
				if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
					jump()
				else:
					blobsprite.play("idle")
				
					
		velocity.y += GRAVITY
		
		set_velocity(velocity)
		set_up_direction(Vector2(0,-1))
		move_and_slide()
		velocity = velocity

		

		if is_on_floor():
			if not on_ground:
				$soundfallmed.play()	
				on_ground = true
		else:
			on_ground = false
			velocity.y += GRAVITY
			if velocity.y < 5:
				blobsprite.play("idle")
			
		
		if on_ground:
			velocity.x = lerp(velocity.x, 0.0, 0.1)
		else:
			velocity.x = lerp(velocity.x, 0.0, 0.01)
			
		if get_slide_collision_count() > 0:
			for i in range(get_slide_collision_count()):
				if "Deadly" in get_slide_collision(i).get_collider().name:
					dead()
		

func _on_timer_timeout():
	Transition.change_scene_to_file("res://scenes/game_over.tscn")
	is_dead = false
