extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Hvor mange hopp spilleren kan gjøre (1 = normalt hopp, 2 = double jump)
const MAX_JUMPS = 2
var jumps_left = MAX_JUMPS

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Reset hopp når spilleren treffer bakken
	if is_on_floor():
		jumps_left = MAX_JUMPS

	# Jump handling
	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1

	# Movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
