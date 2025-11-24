extends Area2D

@export var target_scene: String = "res://CR_Scene4.tscn"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	if body.is_in_group("player"):
		get_node("/root/PlayerStats").health -= 1
		get_node("/root/PlayerStats").health_changed.emit()

		if get_node("/root/PlayerStats").health <= 0:
			get_tree().change_scene_to_file(target_scene)
