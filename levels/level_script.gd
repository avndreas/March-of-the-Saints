extends Node

@onready var world_environment: WorldEnvironment = $WorldEnvironment
@onready var directional_light_3d: DirectionalLight3D = $DirectionalLight3D
@onready var player: CharacterBody3D = $Player

var max_faith : float
var faith : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_faith = player.get_max_faith()
	faith = player.get_faith()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	max_faith = player.get_max_faith()
	faith = player.get_faith()
	world_environment.environment.set_bg_energy_multiplier(1.0 * faith / max_faith)
	world_environment.environment.set_tonemap_exposure(1.0 * faith / max_faith)
	world_environment.environment.set_fog_sky_affect(1.0 * faith / max_faith)
	world_environment.environment.set_fog_density(1.0 - (1.0 * faith / max_faith))
	directional_light_3d.light_energy = 1.0 * faith / max_faith
	print(faith)
