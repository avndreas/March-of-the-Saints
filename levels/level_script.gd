extends Node

@onready var world_environment: WorldEnvironment = $WorldEnvironment
@onready var directional_light_3d: DirectionalLight3D = $DirectionalLight3D
@onready var player: CharacterBody3D = $Player
@onready var MarchOfTheSaints = preload("res://audio/March Of The Saints.mp3")

var max_faith : float
var faith : float
var current_level
var checkpoint : Vector3 = Vector3(0.0, 0.5, 0.0)
var audioPlayer: AudioStreamPlayer = AudioStreamPlayer.new()
var playing: bool = false
var windDown: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_faith = player.get_max_faith()
	faith = player.get_faith()
	player.global_position = checkpoint
	print("Translated player to: ", checkpoint)
	add_child(audioPlayer)
	audioPlayer.volume_db = 1.0
	audioPlayer.set_stream(MarchOfTheSaints)
	#audioPlayer.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	max_faith = player.get_max_faith()
	faith = player.get_faith()
	world_environment.environment.set_bg_energy_multiplier(1.0 * faith / max_faith)
	world_environment.environment.set_tonemap_exposure(1.0 * faith / max_faith)
	world_environment.environment.set_fog_sky_affect(1.0 * faith / max_faith)
	world_environment.environment.set_fog_density(1.0 - (1.0 * faith / max_faith))
	directional_light_3d.light_energy = 1.0 * faith / max_faith
	
	var position = player.global_position
	
	if position.y <= -20.0:
		player.death()
	
	if position.z > -550:    # simple blocks
		current_level = 0
		#print("current level: 0")
		checkpoint = Vector3(0.0, 0.5, 0.0)
	elif position.z > -1300: # simple blocks + angels
		current_level = 1
		checkpoint = Vector3(0.0, 0.5, -550.0)
		#print("current level: 1")
	elif position.z > -2315: # advanced blocks + angels
		current_level = 2
		checkpoint = Vector3(0.0, 0.5, -1300.0)
		#print("current level: 2")
	elif position.z > -3380: # scripted blocks + more angels
		current_level = 3
		if not playing:
			audioPlayer.play()
			playing = true
		checkpoint = Vector3(0.0, 0.5, -2315.0)
		#print("current level: 3")
	else:                    # win condition
		current_level = 4
		if not windDown:
			windDown = true
			while audioPlayer.volume_db >= 0.0:
				audioPlayer.volume_db -= 0.2
			playing = false
			audioPlayer.stop()
			
		print("current level: 4")
	#print("Checkpoint:", checkpoint)
	player.set_level(current_level)

func get_current_level() -> int:
	return current_level

func get_checkpoint() -> Vector3:
	return checkpoint


func _on_win_box_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name.match("Player"):
		Universe.switch_scene(5)
	
