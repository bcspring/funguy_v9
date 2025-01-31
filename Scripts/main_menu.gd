extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	OptionsManager.set_window_mode()
	OptionsManager.resize_window()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/game.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/settings_menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
