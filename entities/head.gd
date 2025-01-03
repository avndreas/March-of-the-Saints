extends Node3D

const UP = Vector3(PI / 2.0, 0.0, 0.0)
const FORWARDS = Vector3(0.0, 0.0, 1.0)

@onready var head: Node3D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var lerpWeight = delta * 15.0
	
	if Input.is_action_pressed("look_up"):
		head.rotation.x = lerp_angle(head.rotation.x, PI * 0.5, lerpWeight)
		head.rotation.y = lerp_angle(head.rotation.y, 0.0, lerpWeight)
		head.rotation.z = lerp_angle(head.rotation.z, 0.0, lerpWeight)
	elif Input.is_action_pressed("look_down"):
		head.rotation.x = lerp_angle(head.rotation.x, -PI * 0.5, lerpWeight)
		head.rotation.y = lerp_angle(head.rotation.y, 0.0, lerpWeight)
		head.rotation.z = lerp_angle(head.rotation.z, 0.0, lerpWeight)
	elif Input.is_action_pressed("look_watch"):
		head.rotation.x = lerp_angle(head.rotation.x, -PI * 0.20, lerpWeight)
		head.rotation.y = lerp_angle(head.rotation.y, -PI * 0.15, lerpWeight)
		head.rotation.z = lerp_angle(head.rotation.z, 0.0, lerpWeight)
	elif Input.is_action_pressed("look_left"):
		head.rotation.x = lerp_angle(head.rotation.x, 0.0, lerpWeight)
		head.rotation.y = lerp_angle(head.rotation.y, PI * 0.5, lerpWeight)
		head.rotation.z = lerp_angle(head.rotation.z, 0.0, lerpWeight)
	elif Input.is_action_pressed("look_right"):
		head.rotation.x = lerp_angle(head.rotation.x, 0.0, lerpWeight)
		head.rotation.y = lerp_angle(head.rotation.y, -PI * 0.5, lerpWeight)
		head.rotation.z = lerp_angle(head.rotation.z, 0.0, lerpWeight)
	else:
		head.rotation.x = lerp_angle(head.rotation.x, 0.0, lerpWeight)
		head.rotation.y = lerp_angle(head.rotation.y, 0.0, lerpWeight)
		head.rotation.z = lerp_angle(head.rotation.z, 0.0, lerpWeight)
