extends Node

@onready var win_screen: CanvasLayer = $WinScreen
@onready var restart_button: Button = $WinScreen/UIContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_screen.hide()
	restart_button.add_theme_font_size_override("font_size", 32)
	restart_button.pressed.connect(_on_restart_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_tree().get_nodes_in_group("notes").is_empty():
		win_screen.show()
		set_process(false)

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
