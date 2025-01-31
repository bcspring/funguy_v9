extends Control


@onready var window_size_option_button: OptionButton = $PanelContainer/VBoxContainer/AudioOptions/VBoxContainer/GridContainer/WindowSizeOptionButton
@onready var full_screen_button: CheckButton = $PanelContainer/VBoxContainer/AudioOptions/VBoxContainer/GridContainer/FullScreenButton


var options

func _ready():
	$AnimationPlayer.play("RESET")
	options = OptionsManager.read_options()
	if options.has("full_screen"):
		full_screen_button.set_pressed_no_signal(options.full_screen)
	window_size_option_button.clear()
	var screen_size = DisplayServer.screen_get_size()
	var index = 0
	for size in OptionsManager.window_size_list:
		if size.width <= screen_size.x and size.height <= screen_size.y:
			window_size_option_button.add_item(str(size.width) + " x " + str(size.height))
			if options.has("window_width") and size.width == options.window_width and options.has("window_height") and size.height:
				window_size_option_button.select(index)
			index += 1



func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	visible = false

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	visible = true

func testEsc():
	if Input.is_action_just_pressed("escape") and !get_tree().paused:
		pause()
	
	elif Input.is_action_just_pressed("escape") and get_tree().paused:
		resume()



func _on_resume_pressed():
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()



func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_confirm_pressed():
	AudioServer.set_bus_volume_db(0, linear_to_db($PanelContainer/VBoxContainer/AudioOptions/VBoxContainer/MasterSlider.value))
	AudioServer.set_bus_volume_db(1, linear_to_db($PanelContainer/VBoxContainer/AudioOptions/VBoxContainer/MusicSlider.value))
	AudioServer.set_bus_volume_db(2, linear_to_db($PanelContainer/VBoxContainer/AudioOptions/VBoxContainer/SFXSlider.value))
	resume()


func _process(delta):
	testEsc()
	

func _on_window_size_option_button_item_selected(index):
	var size = OptionsManager.window_size_list[index]
	options.window_width = size.width
	options.window_height = size.height
	OptionsManager.write_options(options)
	OptionsManager.resize_window()


func _on_full_screen_button_toggled(button_pressed):
	options.full_screen = button_pressed
	OptionsManager.write_options(options)
	OptionsManager.set_window_mode()
	OptionsManager.resize_window()
