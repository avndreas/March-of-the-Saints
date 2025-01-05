extends CharacterBody3D

@onready var bible: Node3D = $Bible
@onready var directional_light_3d: DirectionalLight3D = $"../DirectionalLight3D"
@onready var world_environment: WorldEnvironment = $"../WorldEnvironment"
@onready var faith : float
@onready var test_level: Node3D = $".."

const SPEED = 10.0
const SPRINT = 25.0
const JUMP_VELOCITY = 16
const MAX_FAITH = 777.77

var current_level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bible.visible = false
	faith = MAX_FAITH


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("look_bible"):
		bible.visible = true
		if faith + 3.3 <= MAX_FAITH:
			faith += 3.3
	elif faith - 0.33 >= 0:
		faith -= 0.33
	
	if Input.is_action_just_released("look_bible"):
		bible.visible = false
	

	
	


func _physics_process(delta: float) -> void:
	var speed = SPEED
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	## Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("sprint"):
		speed = SPRINT
		
	if Input.is_action_just_released("sprint"):
		speed = SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func get_faith() -> int:
	return faith

func get_max_faith() -> int:
	return MAX_FAITH

func get_level() -> int:
	return current_level

func set_level(level: int) -> void:
	current_level = level
	
func death() -> void:
	global_position = Vector3(0.0, 8000.0, 0.0)
	await get_tree().create_timer(3).timeout
	faith = MAX_FAITH
	global_position = test_level.get_checkpoint()
