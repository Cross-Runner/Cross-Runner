extends Area2D

@export var target_scene: String = "res://CR_Scene4.tscn"

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	# Sjekk at det er spilleren som går inn i området
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(target_scene)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
