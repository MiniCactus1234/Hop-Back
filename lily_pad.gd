extends StaticBody2D

@export var bounce_strength: float = -700.0
var is_alive: bool = false
signal came_alive

@onready var sprite: Sprite2D = $Sprite2D

func bounce() -> float:
	if not is_alive:
		come_alive()
	# Little squash so the pad reacts to the frog
	var squash := create_tween()
	squash.tween_property(sprite, "scale", Vector2(1.3, 0.7), 0.06)
	squash.tween_property(sprite, "scale", Vector2.ONE, 0.12)
	return bounce_strength

func come_alive() -> void:
	is_alive = true
	came_alive.emit()
	var fade := create_tween()
	fade.tween_property(sprite, "modulate", Color(0.4, 0.85, 0.4), 0.4)
