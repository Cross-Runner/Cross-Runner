extends Button

func _ready() -> void:
	connect("pressed", Callable(self, "_on_pressed"))

func _on_pressed() -> void:
	if SceneManager.last_scene_path != "":
		get_tree().change_scene_to_file(SceneManager.last_scene_path)
