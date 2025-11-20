extends CharacterBody2D

@export var max_health: int = 100
@export var attack_damage: int = 15
@export var attack_cooldown_time: float = 2.0
@export var move_speed: float = 20.0

var health: int
var can_attack := true
var player = null

@onready var anim = $AnimationPlayer
@onready var sprite = $AnimatedSprite2D
@onready var hitbox = $AttackHitbox
@onready var cooldown = $AttackCooldown
@onready var health_bar = $HealthBar

func _ready():
	health = max_health
	health_bar.max_value = max_health
	health_bar.value = max_health
	
	# Detect when the player enters
	$PlayerDetect.body_entered.connect(_on_player_detected)
	$PlayerDetect.body_exited.connect(_on_player_left)
	
	# Detect when hitbox hits player
	hitbox.body_entered.connect(_on_hit_player)
	
	cooldown.wait_time = attack_cooldown_time
	cooldown.timeout.connect(_on_cooldown_finished)

func _physics_process(delta):
	if player:
		# Simple movement toward player (optional)
		var direction = sign(player.global_position.x - global_position.x)
		velocity.x = direction * move_speed
		move_and_slide()
	else:
		velocity.x = 0

func _on_player_detected(body):
	if body.name == "Player":
		player = body
		attack()

func _on_player_left(body):
	if body == player:
		player = null

func attack():
	if not can_attack:
		return
	can_attack = false
	anim.play("attack")            # Your attack animation
	hitbox.monitoring = true       # Enable hitbox only when attacking
	
	cooldown.start()               # Start cooldown timer

func _on_cooldown_finished():
	can_attack = true
	hitbox.monitoring = false      # Hitbox off until next attack
	if player:
		attack()

func _on_hit_player(body):
	if body.name == "Player":
		if body.has_method("take_damage"):
			body.take_damage(attack_damage)

# Boss takes damage from player
func take_damage(amount: int):
	health -= amount
	health_bar.value = health
	anim.play("hurt")

	if health <= 0:
		die()

func die():
	anim.play("death")
	set_physics_process(false)
	hitbox.monitoring = false
	$CollisionShape2D.disabled = true
