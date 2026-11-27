extends Area2D

signal came_alive

var is_alive = false

@onready var sprite = $Sprite2D


func come_alive():
	if is_alive:
		return

	is_alive = true
	came_alive.emit()

	var fade = create_tween()
	fade.tween_property(sprite, "modulate", Color(1.0, 0.5, 0.7), 0.5)
