extends CharacterBody2D

<<<<<<< HEAD
var health = 500
var stunned = false
var stun_timer = 0.0
=======
const SPEED = 100.0
const JUMP_VELOCITY = -200.0

const MAX_JUMPS = 2
var jumps_left = MAX_JUMPS

@onready var anim = $AnimatedSprite2D
@onready var coin_label = %Label
@onready var sfx_attack: AudioStreamPlayer2D = $"../sfx_attack"
@onready var sfx_jump: AudioStreamPlayer2D = $"../sfx_jump"
@onready var sfx_coin: AudioStreamPlayer2D = $"../sfx_coin"



# For å hindre at man "avbryter" attack med idle/walk
var is_attacking = false
>>>>>>> 99cc24945278296f8c06a1e423dad4b6b1c984b0

var coin_counter = 0

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
<<<<<<< HEAD
		move_and_slide()
=======

	# Reset jumps when grounded
	if is_on_floor():
		jumps_left = MAX_JUMPS

	# Attack
	if Input.is_action_just_pressed("attack") and not is_attacking:
		sfx_attack.play()
		_play_attack()
		return  # stopper videre bevegelses/animasjonslogikk mens attack spiller

	# Jump
	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		sfx_jump.play()
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
>>>>>>> 99cc24945278296f8c06a1e423dad4b6b1c984b0
	else:
		# Force velocity to zero just to be safe
		velocity = Vector2.ZERO

# --- Combat Functions ---
func take_damage(amount):
	health -= amount
	print("Boss HP: ", health)
	if health <= 0:
		queue_free()

<<<<<<< HEAD
func stun(time):
	stunned = true
	stun_timer = time
	
=======
	move_and_slide()


func _play_attack() -> void:
	is_attacking = true
	anim.play("attack")

	# Når attack-animasjonen er ferdig, gå tilbake til idle
	await anim.animation_finished

	is_attacking = false

func _on_area_2d_coin_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		sfx_coin.play()
		set_coin(coin_counter + 1)
		print(coin_counter)

func set_coin(new_coin_count: int) -> void:
	coin_counter = new_coin_count
	coin_label.text = "Coin Count: " + str(coin_counter )
>>>>>>> 99cc24945278296f8c06a1e423dad4b6b1c984b0
