extends CanvasLayer

@onready var menubutton: Button = $Control/MarginContainer/VBoxContainer/menubutton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menubutton.pressed.connect( _menu )
	pass # Replace with function body.


func _menu () -> void:
	await SceneTransition.fade_to_black ()
	get_tree().change_scene_to_file("res://Scenes/UI/mainmenu.tscn")
