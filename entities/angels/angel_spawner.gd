extends Node3D

@onready var angel = preload("res://entities/angels/angel.tscn")
@onready var player: CharacterBody3D = $"../Player"

@export var direction : bool
@export var zMin : int = 10
@export var zMax : int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	var angelInstance = angel.instantiate()
	var playerPos = player.global_position

	var randZ = rng.randi_range(playerPos.z + zMin, playerPos.z - zMax)
	angelInstance.translate(Vector3(0.0, 0.0, randZ))
	angelInstance.rotate(Vector3(0.0, 1.0, 0.0), PI * int(direction))
	get_node("Angels").add_child(angelInstance)
