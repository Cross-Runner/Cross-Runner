extends CharacterBody2D

var health = 500
var stunned = false
var stun_timer = 0.0

func _physics_process(delta: float) -> void:
	# 1. Stun Timer
	if stunned:
		stun_timer -= delta
		if stun_timer <= 0:
			stunned = false
			print("Boss recovered!")

	# 2. Gravity Logic ONLY
	# We only run the physics engine if the boss is in the air.
	# Once he hits the floor, we STOP calling move_and_slide().
	# This prevents the player from pushing him.
	if not is_on_floor():
		velocity += get_gravity() * delta
		move_and_slide()
	else:
		# Force velocity to zero just to be safe
		velocity = Vector2.ZERO

# --- Combat Functions ---
func take_damage(amount):
	health -= amount
	print("Boss HP: ", health)
	if health <= 0:
		queue_free()

func stun(time):
	stunned = true
	stun_timer = time
	
