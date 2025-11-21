extends CharacterBody2D   # or whatever your boss uses

@export var max_health: int = 300
var health: int = max_health

signal boss_health_changed(new_value)

func take_damage(amount: int):
	health = clamp(health - amount, 0, max_health)
	emit_signal("boss_health_changed", health)

func heal(amount: int):
	health = clamp(health + amount, 0, max_health)
	emit_signal("boss_health_changed", health)
