extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -200.0

const MAX_JUMPS = 2
var jumps_left = MAX_JUMPS

@onready var anim = $AnimatedSprite2D

# For å hindre at man "avbryter" attack med idle/walk
var is_attacking = false

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Reset jumps when grounded
	if is_on_floor():
		jumps_left = MAX_JUMPS

	# Attack
	if Input.is_action_just_pressed("attack") and not is_attacking:
		_play_attack()
		return  # stopper videre bevegelses/animasjonslogikk mens attack spiller

	# Jump
	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1

	# Movement
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED

		# Flip sprite depending on direction
		anim.flip_h = direction < 0

		if is_on_floor() and not is_attacking:
			if anim.animation != "walk":
				anim.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		if is_on_floor() and not is_attacking:
			if anim.animation != "idle":
				anim.play("idle")

	move_and_slide()


func _play_attack() -> void:
	is_attacking = true
	anim.play("attack")

	# Når attack-animasjonen er ferdig, gå tilbake til idle
	await anim.animation_finished

	is_attacking = false
