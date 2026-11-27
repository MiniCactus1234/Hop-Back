extends Node2D

@onready var background: ColorRect = $Background
var pads_total: int = 0
var pads_alive: int = 0

func _ready() -> void:
	# TODO 1: Loop through all children of $LilyPads
	#   for pad in $LilyPads.get_children():
	#   For each one: add 1 to pads_total,
	#   and connect its came_alive signal to _on_pad_came_alive
	#   (hint: pad.came_alive.connect(_on_pad_came_alive))
	for pad in $LilyPads.get_children():
		pads_total += 1
		pad.came_alive.connect(_on_pad_came_alive)

func _on_pad_came_alive():
	pads_alive += 1

	if pads_alive == pads_total:
		level_complete()

func level_complete():
	print("Level complete!")

	var fade = create_tween()
	fade.tween_property(background, "color", Color(0.6, 0.85, 0.95), 1.5)
