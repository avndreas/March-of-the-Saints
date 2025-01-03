extends CharacterBody3D

@onready var player: Node3D = $".."

const SPEED = 8.0
const SPRINT = 16.0
const JUMP_VELOCITY = 16
const MAX_FAITH = 777

var faith

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	faith = MAX_FAITH


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("look_watch"):
		if faith + 7 <= MAX_FAITH:
			faith += 7
	elif faith - 7 >= 0:
		faith -= 7
	


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
