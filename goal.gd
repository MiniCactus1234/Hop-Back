extends Area2D
@export_file("*.tscn") var next_level: String
var is_open: bool = false
func _ready() -> void:
	body_entered.connect(_on_body_entered)
func open() -> void:
	is_open = true
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate", Color("47ff00ff"), 0.3)
func _on_body_entered(body):
	if body.name == "Frog" and is_open:
		if next_level != "":
			get_tree().change_scene_to_file(next_level)
