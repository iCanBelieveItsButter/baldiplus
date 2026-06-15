extends Control

@onready var cursor : Sprite2D = $cur

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		$AudioStreamPlayer2.play()

func _physics_process(delta: float) -> void:
	cursor.position = get_local_mouse_position()


func _on_about_butt_mouse_entered() -> void:
	$AboutLit.visible=true

func _on_about_butt_mouse_exited() -> void:
	$AboutLit.visible=false


func _on_options_butt_mouse_entered() -> void:
	$OptionsLit.visible=true

func _on_options_butt_mouse_exited() -> void:
	$OptionsLit.visible=false



func _on_play_butt_mouse_entered() -> void:
	$PlayLit.visible=true

func _on_play_butt_mouse_exited() -> void:
	$PlayLit.visible=false
