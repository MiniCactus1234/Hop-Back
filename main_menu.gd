
extends Control

var hat_names = [
	"none",
	"top hat",
	"flower crown",
    "leaf"
]
func _ready() -> void:
	$VBoxContainer/PlayButton.pressed.connect(_on_play_button_pressed)
	$VBoxContainer/HatButton.pressed.connect(_on_hat_button_pressed)
	update_hat_button()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")
func _on_hat_button_pressed() -> void:
	GameData.hat = (GameData.hat + 1) % 4
	update_hat_button()
func update_hat_button() -> void:
	$VBoxContainer/HatButton.text = "Hat: " + hat_names[GameData.hat]
