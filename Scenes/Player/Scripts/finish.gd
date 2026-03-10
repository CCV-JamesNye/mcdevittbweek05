extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect( _check_for_win )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _check_for_win (body : Node2D) -> void:
	if body.name == "player":
		await SceneTransition.fade_to_black()
		get_tree().change_scene_to_file("res://Scenes/victory_screen.tscn")
	
