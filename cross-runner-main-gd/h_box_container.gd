extends HBoxContainer

func _ready():
	get_node("/root/PlayerStats").health_changed.connect(update_hearts)
	update_hearts()

func update_hearts():
	var stats = get_node("/root/PlayerStats")
	for i in range(get_child_count()):
		get_child(i).visible = i < stats.health
