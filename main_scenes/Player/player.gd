extends CharacterBody3D

@onready var head : Node3D = $head
@onready var cam = $head/Camera3D

const SPEED := 10.0
const SPRINT_SPEED := 16.0
var speed_using := 10.0

var mouse_sen := 0.1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sen))

func _physics_process(delta):

	head.rotation.y = 0.0 if !Input.is_action_pressed("look_behind") else deg_to_rad(180.0)

	if Input.is_action_pressed("sprint"):
		speed_using = SPRINT_SPEED
	else:
		speed_using = SPEED

	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed_using
		velocity.z = direction.z * speed_using
	else:
		velocity.x = move_toward(velocity.x, 0, speed_using)
		velocity.z = move_toward(velocity.z, 0, speed_using)

	move_and_slide()
