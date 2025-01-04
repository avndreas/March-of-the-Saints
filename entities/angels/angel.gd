extends Node3D

@onready var angel: Node3D = $"."
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	angel.translate(Vector3(60.0 * delta , 0.0, 0.0))


func _on_timer_timeout() -> void:
	queue_free()
